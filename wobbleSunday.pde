import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fftLin;
FFT fftLog;


//some variables to hold the current polyhedron...
float ang = 1;
float speed = 1.5;
ArrayList verts;
float dispSz, edgeLength;
String strName, strNotes;
int currID = 14;
int wTime = 0;
boolean wobble = false;
boolean showLined = false;
int wobbleRatio = 75;


 float cx = 0;
 float cy = 0;
 float cz = 0;

//================================================================
void setup() {
  size(700, 450, P3D);
  smooth();

  minim = new Minim(this);
  in = minim.getLineIn(minim.MONO, 256);

  //set up initial polyhedron
  verts = new ArrayList();
  setupPoly();
}

//================================================================
void draw() {
  //setup the view
  background(0);
  translate(width/2, height/2, -200);

  //draw the polyhedron
  strokeWeight(.75);
  stroke(255);
  rotateY(radians(mouseX)); // Rotating the sphere up & down
  rotateX(radians(mouseY)); // Rotating the sphere left & right

  sphere(23);

  stroke(255, 0, 0);
  line(0, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 100);

  stroke(255);

  for(int i=0; i<verts.size(); i++) {
    for(int j=i + 1; j<verts.size(); j++) {
      pushMatrix();
      float left = in.left.get(0);
      float right = in.right.get(0);
      if(isEdge(i, j)) {
        //translate(random(wobbleRatio*left), random(wobbleRatio*right),random(wobbleRatio * (left + right)));
        vLine((vert)verts.get(i), (vert)verts.get(j));
      }
      popMatrix();
    }
  }

  ang+=speed;
  wTime++;
  if(wTime > 100) {
     wobble = false;
  }

}

//================================================================
void vLine(vert v1, vert v2) {
  //Draws an edge line
  if(showLined) {
    line(v1.x*dispSz, v1.y*dispSz, v1.z*dispSz, v2.x*dispSz, v2.y*dispSz, v2.z*dispSz);
  }
  vert v1Scaled = v1.scale(dispSz);
  vert v2Scaled = v2.scale(dispSz);
  float dStep = vertDistance(v1Scaled, v2Scaled) / (float)in.bufferSize();

  vert vCurrent = v1Scaled;
  vert origin = new vert(1, 1, 1);
  stroke(0, 255, 0);
  origin.drawVert();
  for(int i = 0; i < in.bufferSize() - 1; i++) {
    vert vStep = v2Scaled.sub(vCurrent).scale(dStep/32);
    vCurrent.addVert(vStep);
    vCurrent.addScalar(in.left.get(i)*50);

    stroke(255);
    vCurrent.drawVert();
    stroke(255, 0, 0);
    vert crossed = vStep.crossProduct(vCurrent);
    crossed.drawVert();
    stroke(0, 255, 0);
    vert vNorm = vCurrent.add(crossed);
    vNorm.drawVert();
  }
}

float vertDistance(vert v1, vert v2) {
  float dxsq = (v1.x - v2.x) * (v1.x - v2.x);
  float dysq = (v1.y - v2.y) * (v1.y - v2.y);
  float dzsq = (v1.z - v2.z) * (v1.z - v2.z);
  return sqrt(dxsq + dysq + dzsq);
}

//================================================================
boolean isEdge(int vID1, int vID2) {
  //had some rounding errors that were messing things up, so I had to make it a bit more forgiving...
  int pres = 1000;
  vert v1 = (vert)verts.get(vID1);
  vert v2 = (vert)verts.get(vID2);
  float d = sqrt(sq(v1.x - v2.x) + sq(v1.y - v2.y) + sq(v1.z - v2.z)) + .00001;
  return (int(d*pres)==int(edgeLength*pres));

}

vert randomVert(float factor) {
  return(new vert(random(factor), random(factor), random(factor)));
}

//================================================================
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

//================================================================
void addVerts(float x, float y, float z) {
  //adds the requested vert and all "mirrored" verts
  verts.add (new vert(x, y, z));
  if (z != 0.0) verts.add (new vert(x, y, -z));
  if (y != 0.0) {
    verts.add (new vert(x, -y, z));
    if (z != 0.0) verts.add (new vert(x, -y, -z));
  }
  if (x != 0.0) {
    verts.add (new vert(-x, y, z));
    if (z != 0.0) verts.add(new vert(-x, y, -z));
    if (y != 0.0) {
      verts.add (new vert(-x, -y, z));
      if (z != 0.0) verts.add (new vert(-x, -y, -z));
    }
  }
}

//================================================================
void addPermutations(float x, float y, float z) {
  //adds vertices for all three permutations of x, y, and z
  addVerts(x, y, z);
  addVerts(z, x, y);
  addVerts(y, z, x);
}

//================================================================
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

void mouseClicked() {
   setupPoly();
   wobble = !wobble;
   wTime = 0;
}

void keyPressed() {
  if(keyCode == 'A') {
    showLined = !showLined;
  }
}

