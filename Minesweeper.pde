import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 60;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++)
      for (int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new MSButton(r, c);
    
    setMines();
}
public void setMines()
{
    //your code
    while (mines.size() < NUM_MINES) {
      int row = (int)(Math.random()*NUM_ROWS);
      int col = (int)(Math.random()*NUM_COLS);
      if (!mines.contains(row) && !mines.contains(col)) {
       mines.add(buttons[row][col]);
       //System.out.println(row + ", " + col);
      }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].clicked == false && !mines.contains(buttons[r][c]))
          return false;
      }
    }
    
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        if(buttons[r][c].clicked == false && mines.contains(buttons[r][c])){
          buttons[r][c].clicked = true;
        }
      }
    }
     for(int i = 0; i < 20; i++)
      buttons[8][i].setLabel(" ");
    buttons[9][0].setLabel(" ");
    buttons[9][1].setLabel(" ");
    buttons[9][2].setLabel(" ");
    buttons[9][3].setLabel(" ");
    buttons[9][4].setLabel("Y");
    buttons[9][5].setLabel("O");
    buttons[9][6].setLabel("U");
    buttons[9][7].setLabel("'");
    buttons[9][8].setLabel("R");
    buttons[9][9].setLabel("E");
    buttons[9][10].setLabel(" ");
    buttons[9][11].setLabel("N");
    buttons[9][12].setLabel("O");
    buttons[9][13].setLabel("T");
    buttons[9][14].setLabel("");
    buttons[9][15].setLabel(" ");
    buttons[9][16].setLabel(" ");
    buttons[9][17].setLabel(" ");
    buttons[9][18].setLabel(" ");
    buttons[9][19].setLabel(" ");
    buttons[10][0].setLabel(" ");
    buttons[10][1].setLabel(" ");
    buttons[10][2].setLabel(" ");
    buttons[10][3].setLabel(" ");
    buttons[10][4].setLabel(" ");
    buttons[10][5].setLabel(" ");
    buttons[10][6].setLabel("V");
    buttons[10][7].setLabel("E");
    buttons[10][8].setLabel("R");
    buttons[10][9].setLabel("Y");
    buttons[10][10].setLabel(" ");
    buttons[10][11].setLabel("G");
    buttons[10][12].setLabel("O");
    buttons[10][13].setLabel("O");
    buttons[10][14].setLabel("D");
    buttons[10][15].setLabel(" ");
    buttons[10][16].setLabel(" ");
    buttons[10][17].setLabel(" ");
    buttons[10][18].setLabel(" ");
    buttons[10][19].setLabel(" ");
          
    for(int i = 0; i < 20; i++)
      buttons[11][i].setLabel(" ");
}
public void displayWinningMessage()
{
    //your code here
     for(int i = 0; i < 20; i++)
      buttons[8][i].setLabel(" ");
    
    buttons[9][0].setLabel(" ");
    buttons[9][1].setLabel(" ");
    buttons[9][2].setLabel("N");
    buttons[9][3].setLabel("O");
    buttons[9][4].setLabel("T");
    buttons[9][5].setLabel(" ");
    buttons[9][6].setLabel("T");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("O");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("S");
    buttons[9][11].setLabel("H");
    buttons[9][12].setLabel("A");
    buttons[9][13].setLabel("B");
    buttons[9][14].setLabel("B");
    buttons[9][15].setLabel("Y");
    buttons[9][16].setLabel("!");
    buttons[9][17].setLabel(" ");
    buttons[9][18].setLabel(" ");
    buttons[9][19].setLabel(" ");
    
    for(int i = 0; i < 20; i++)
      buttons[10][i].setLabel(" ");
}
public boolean isValid(int r, int c)
{
    //your code here
    return (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS);
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for (int r = row-1; r <= row+1; r++)
      for (int c = col-1; c <= col+1; c++) {
        if (isValid(r, c) && mines.contains(buttons[r][c]))
          numMines++;
         if (mines.contains(buttons[row][col]))
           numMines--;
      }
    //System.out.println("num: " + numMines);
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
          
          if(flagged == true){
            flagged = false;
            clicked = false;
          }
            
          if(flagged == false){
            flagged = true; 
          }
        }
        
        else if(mines.contains(this))
          displayLosingMessage();
          
        else if(countMines(myRow, myCol) > 0)
          setLabel(countMines(myRow, myCol));
          
        else{
          for(int i = -1; i < 2; i++){
            if(isValid(myRow + i, myCol - 1) == true && buttons[myRow + i][myCol - 1].clicked == false)
              buttons[myRow + i][myCol - 1].mousePressed();
          }
          
          if(isValid(myRow - 1, myCol) == true && buttons[myRow - 1][myCol].clicked == false)
              buttons[myRow - 1][myCol].mousePressed();
              
          if(isValid(myRow + 1, myCol) == true && buttons[myRow + 1][myCol].clicked == false)
              buttons[myRow + 1][myCol].mousePressed();
          
          for(int i = -1; i < 2; i++){
            if(isValid(myRow + i, myCol + 1) == true && buttons[myRow + i][myCol + 1].clicked == false)
              buttons[myRow + i][myCol + 1].mousePressed();
          }
        }
            
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
