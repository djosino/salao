var circle = new Sonic({
  width: 210,
  height: 210,

  stepsPerFrame: 2,
  trailLength: 0.7,
  pointDistance: .005,
  fps: 30,

  fillColor: '#27598c',

  step: function(point, index) {
    
    this._.beginPath();
    this._.moveTo(point.x, point.y);
    this._.arc(point.x, point.y, index * 10, 0, Math.PI*2, false);
    this._.closePath();
    this._.fill();

  },

  path: [ ['arc', 100, 100, 60, 0, 720] ]
});
 
circle.play();
