import ddf.minim.*;
import ddf.minim.analysis.*;

//-------------------------------------------------------------------------------
//                                                                        GLOBALS
//-------------------------------------------------------------------------------
// Audio:
Minim minim;
AudioInput in;
FFT fftLin;
FFT fftLog;

// Effects:
PShader blur;
int numberOfPasses = 1;

// Rotation:
float ang = 1;
float speed = 1.5;

// Vertices:
ArrayList verts;

// Scaling:
float dispSz, edgeLength;

// Timing:
int wTime = 0;

// Wave Amplification:
float amplificationFactor = 5;

//-------------------------------------------------------------------------------
//                                                                 INITIALISATION
//-------------------------------------------------------------------------------
void setup() {
  size(700, 450, P3D);
  smooth();

  minim = new Minim(this);
  in = minim.getLineIn(minim.STEREO, 64);

  blur = loadShader("blur.glsl");

  //set up initial polyhedron
  verts = new ArrayList();
  setupPoly();
}

//-------------------------------------------------------------------------------
//                                                                          DRAWS
//-------------------------------------------------------------------------------
void draw() {
  //setup the view
  background(0);
  translate(width/2, height/2, -200);

  handleInteraction();

  drawPolyhedron();

  ang+=speed;
  wTime++;
}

void drawPolyhedron() {
  strokeWeight(.75);
  stroke(255);
  for(int k = 0; k < numberOfPasses; k++) {
    filter(blur);
    for(int i=0; i<verts.size(); i++) {
      for(int j=i + 1; j<verts.size(); j++) {
        if(isEdge(i, j)) {
          drawLine((vert)verts.get(i), (vert)verts.get(j));
        }
      }
    }
  }
}

void drawLine(vert v1, vert v2) {
  //Draws an edge line
  vert v1Scaled = v1.scale(dispSz);
  vert v2Scaled = v2.scale(dispSz);
  float dStep = vertDistance(v1Scaled, v2Scaled) / (float)in.bufferSize();

  vert vCurrent = v1Scaled;
  vert origin = new vert(1, 1, 1);
  for(int i = 0; i < in.bufferSize() - 1; i++) {
    float soundIn = in.left.get(i)*amplificationFactor;
    vert vStep = v2Scaled.sub(vCurrent).scale(dStep/32);
    vCurrent.addVert(vStep);
    vCurrent.addScalar(soundIn);

    stroke(255, 0, 0);
    vert crossed = vStep.crossProduct(vCurrent).scale(soundIn);
    crossed.drawVert();
    stroke(255);
    vert vNorm = vCurrent.add(crossed);
    vNorm.drawVert();
  }
}

//-------------------------------------------------------------------------------
//                                                                           DRAW
//                                                                      UTILITIES
//-------------------------------------------------------------------------------
boolean isEdge(int vID1, int vID2) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  vert v1 = (vert)verts.get(vID1);
  vert v2 = (vert)verts.get(vID2);
  float d = vertDistance(v1, v2) + 0.00001;
  return (int(d*pres)==int(edgeLength*pres));

}

//-------------------------------------------------------------------------------
//                                                                     POLYHEDRON
//-------------------------------------------------------------------------------
void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  verts.add (new vert(x, y, z));
  if (z != 0.0) {
    verts.add (new vert(x, y, -z));
  }
  if (y != 0.0) {
    verts.add (new vert(x, -y, z));
    if (z != 0.0) verts.add (new vert(x, -y, -z));
  }
  if (x != 0.0) {
    verts.add (new vert(-x, y, z));
    if (z != 0.0) {
      verts.add(new vert(-x, y, -z));
    }
    if (y != 0.0) {
      verts.add (new vert(-x, -y, z));
      if (z != 0.0) { 
        verts.add (new vert(-x, -y, -z));
      }
    }
  }
}

void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}

void setupPoly() {
  //This is where the actual defining of the polyhedrons takes place

  float PHI = (1 + sqrt(5))/2; //a number of polys use the golden ratio...
  float ROOT2 = sqrt(2); //...and the square root of two

  verts.clear(); //clear out whatever verts are currently defined

  addPermutations(1, 1, pow(PHI, 3));
  addPermutations(sq(PHI), PHI, 2*PHI);
  addPermutations(PHI + 2, 0, sq(PHI));
  edgeLength = 2;
  dispSz = 50;
}
//-------------------------------------------------------------------------------
//                                                                    INTERACTION
//-------------------------------------------------------------------------------
void handleInteraction() {
  rotateY(radians(mouseX)); // Rotating the sphere up & down
  rotateX(radians(mouseY)); // Rotating the sphere left & right
}

void mouseClicked() {
   setupPoly();
   wTime = 0;
}

void keyPressed() {
  if(keyCode == UP) {
    amplificationFactor++;
    println(amplificationFactor);
  }
  if(keyCode == DOWN) {
    amplificationFactor--;
    println(amplificationFactor);
  }
  if(keyCode == 'W') {
    numberOfPasses++;
    println(numberOfPasses);
  }
  if(keyCode == 'Q') {
    numberOfPasses--;
    println(numberOfPasses);
  }
}

//-------------------------------------------------------------------------------
//                                                                       VERTICES
//                                                                          CLASS
//-------------------------------------------------------------------------------
class vert {
  //simple vertex class to hold the numbers
  float x, y, z;
  vert(float xx, float yy, float zz) {
    x = xx;
    y = yy;
    z = zz;
  }

  void drawVert() {
    point(this.x, this.y, this.z);
  }

  vert scale(float factor) {
    return(new vert(this.x * factor, this.y * factor, this.z * factor));
  }

  vert sub(vert v) {
    return(new vert(this.x - v.x, this.y - v.y, this.z - v.z));
  }

  vert add(vert v) {
    return(new vert(this.x + v.x, this.y + v.y, this.z + v.z));
  }

  vert addScalar(float scalar) {
    return(new vert(this.x + scalar, this.y + scalar, this.z + scalar));
  }

  vert crossProduct(vert v) {
    float x = this.y*v.z - this.z*v.y;
    float y = this.z*v.x - this.x*v.z;
    float z = this.z*v.y - this.y*v.x;
    return(new vert(x, y, z));
  }

  void addVert(vert v){
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
  }
}

float vertDistance(vert v1, vert v2) {
  float dxsq = (v1.x - v2.x) * (v1.x - v2.x);
  float dysq = (v1.y - v2.y) * (v1.y - v2.y);
  float dzsq = (v1.z - v2.z) * (v1.z - v2.z);
  return sqrt(dxsq + dysq + dzsq);
}

vert randomVert(float factor) {
  return(new vert(random(factor), random(factor), random(factor)));
}
