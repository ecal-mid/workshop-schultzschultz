
// –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––---–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––– SUBCLASS: FONT –––––––––––––
class ShapeFontItem extends fontItem {
  
    ShapeFontItem (String t, File f, int fI) {
        super(t, f, fI);
    }

    ShapeFontItem (GraphicItem item) {
        super(item);
    }

}