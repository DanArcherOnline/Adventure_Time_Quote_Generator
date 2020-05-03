const String _IMAGES_PATH = 'assets/images/';
const String _PNG_SUFFIX = '.png';

pngImage(String imagePath) => _IMAGES_PATH + imagePath + _PNG_SUFFIX;

class BmoImages {
  static final String blueOvalButton = pngImage('blue_oval_button');
  static final String faceSmile = pngImage('bmo_face_smile');
  static final String diskDrive = pngImage('disk_drive');
  static final String greenOvalButton = pngImage('green_oval_button');
  static final String longOvalButton = pngImage('long_oval_button');
  static final String plusButton = pngImage('plus_button');
  static final String redOvalButton = pngImage('red_oval_button');
  static final String redOvalButtonPressed =
      pngImage('red_oval_button_pressed');
  static final String traingleButton = pngImage('triangle_button');
  static final String faceThink = pngImage('bmo_face_thinking');
}
