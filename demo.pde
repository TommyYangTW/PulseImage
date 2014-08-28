/* 
  PROCESSINGJS.COM - BASIC EXAMPLE
  Delayed Mouse Tracking  
  MIT License - Hyper-Metrix.com/F1LT3R
  Native Processing compatible 
*/  

// Global variables
int[] pulse1=[50,50]; 
int[] pulse2=[50,320];
int area_width=170;  
int area_height=35; 
int area_space=250;

int gWidth=780; 
int gHeight=550;

//////
int Pulse_BloodWidth_1=		011; 
int Pulse_BloodWidth_2=		012; 
int Pulse_BloodWidth_3=		013;

ArrayList pareaList;  
ArrayList pareaSetList; 
ArrayList bloodList;
int areaSelectIdx=-1;
int pulseNumber=30;

//PulseArea Clase
class PulseArea
{
	int x,y,w,h;
	int idx;  
}

//PulseArea Clase
class BloodType
{
	int x,y,w,h;
	int idx;
	int type; 
	int group_size; 
}


// Setup the Processing Canvas
void setup(){
	size( gWidth, gHeight );
	pareaList = new ArrayList();
	bloodList = new ArrayList();
	
	for(int i=0;i<pulseNumber;i++)
	{
		bloodList.add(new ArrayList());              
	}
	 
	strokeWeight( 10 );
	//frameRate( 15 );
	initPulseArea();
	bgDraw(); 
}

void initPulseArea()
{ 
	for(int i=0;i<6;i++)
	{
		for(int j=0;j<5;j++)
		{            
			PulseArea parea=new PulseArea();
			int idx=i*5+j;
			int x_plus=0; 
			int y_plus=0;
			if(i<3)
			{             
				x_plus=pulse1[0]+(area_space*(i%3));
				y_plus=pulse1[1]+(area_height*j)+2; 
			}
			else
			{    
				x_plus=pulse2[0]+(area_space*(i%3));
				y_plus=pulse2[1]+(area_height*j)+2; 
			}
			parea.x=x_plus;    
			parea.y=y_plus;      
			parea.w=area_width;
			parea.h=30;   
			parea.idx=idx;
			pareaList.add(parea); 
		}
	} 
}

void bgDraw()
{   
	//Fill background 
  	fill( 255, 255, 255 ); 
	rect(0, 0, gWidth, gHeight); 
	
	// Fill line
	background( 255 );
	stroke(74, 165, 255);
	strokeWeight(4); // Thicker
  
	for(int j=0;j<3;j++)
	{
		for(int i=0;i<6;i++)
		{
			line(pulse1[0]+(area_space*j), pulse1[1]+(area_height*i), pulse1[0]+area_width+(area_space*j), pulse1[1]+(area_height*i));
		} 
	}
	    
	for(int j=0;j<3;j++)
	{
		for(int i=0;i<6;i++)
		{
			line(pulse2[0]+(area_space*j), pulse2[1]+(area_height*i), pulse2[0]+area_width+(area_space*j), pulse2[1]+(area_height*i));
		} 
	} 
}
          
/* 
// Main draw loop
void draw(){  
  radius = radius + sin( frameCount / 4 );
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas grey
  background( 100 );
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw circle
  ellipse( X, Y, radius, radius ); 
} 
*/                    


// Set circle's next destination
void mouseMoved(){   
  	noStroke();
	for(int i=0;i<pareaList.size();i++)
	{                            
		PulseArea parea=(PulseArea)pareaList.get(i);
		                                            
  		// Set fill-color to white
  		fill( 255, 255, 255 ); 
	  	rect(parea.x, parea.y, parea.w, parea.h);    
		if(areaSelectIdx==parea.idx)
		{                       
  			fill( 255, 255, 0 );
	  		rect(parea.x, parea.y, parea.w, parea.h);
		}
		else
		{  
	  		if(mouseX>=parea.x && mouseX<=(parea.x+parea.w) 
				&& mouseY>=parea.y && mouseY<=(parea.y+parea.h)) 
			{ 
	  			fill( 255, 255, 149, 100 );
	  			rect(parea.x, parea.y, parea.w, parea.h);
			}                
		} 
	}
	drawPulse();
  
}

void mousePressed() { 
  
  	noStroke(0); 
	for(int i=0;i<pareaList.size();i++)
	{                            
		PulseArea parea=(PulseArea)pareaList.get(i);
		                                            
  		// Set fill-color to white
  		fill( 255, 255, 255 );
  		rect(parea.x, parea.y, parea.w, parea.h);
  		
		if(mouseX>=parea.x && mouseX<=(parea.x+parea.w) 
			&& mouseY>=parea.y && mouseY<=(parea.y+parea.h)) 
		{               
			if(areaSelectIdx!=parea.idx)
			{                       
  				fill( 255, 255, 0 );
  				areaSelectIdx=parea.idx;
			}
			else
			{                  
  				areaSelectIdx=-1;
  				fill( 255, 255, 149, 100 );
			}  
  			rect(parea.x, parea.y, parea.w, parea.h);
		}
	}
	drawPulse();

}

void cancelPressed()
{  
  	noStroke(0);
  	areaSelectIdx=-1; 
	for(int i=0;i<pareaList.size();i++)
	{                            
		PulseArea parea=(PulseArea)pareaList.get(i);
		                                            
  		// Set fill-color to white
  		fill( 255, 255, 255 );
  		rect(parea.x, parea.y, parea.w, parea.h);
	}
	drawPulse();
}

void drawPulse()
{
	for(int i=0;i<bloodList.size();i++)
	{                     
		ArrayList blist=(ArrayList)bloodList.get(i); 
		int group_idx=1;      
		       
		for(int j = blist.size()-1;j>= 0;j--)
		{  
			BloodType bt=(BloodType)blist.get(j);
			if(bt.type==11)
			{     
				int y=bt.y+15; 
				//int y2=bt.y+10;
				//int x2=x+120; 
				int x=bt.x+22;
		 			
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker 
				for(int k=0;k<13;k++)
				{  
					line(x+(k*10),y,x+(k*10)+4,y); 
				}   
			}
			else if(bt.type==12)
			{     
				int y=bt.y+15; 
				//int y2=bt.y+10;
				int x=bt.x+22; 
				int x2=x+120; 
		 			
				// Set stroke-color white
				stroke(0);    
				strokeWeight(2); // Thicker
				line(x,y,x2,y);    
			}
			else if(bt.type>=13 && bt.type<=17)
			{     
				int y=bt.y+5; 
				int y2=0;
				int x=bt.x+22; 
				int x2=x+120; 
				
				if(bt.type<16)
				{
					y=bt.y+9; 
					y2=y+(bt.type-12)*3;
				}
				else    
					y2=y+(bt.type-12)*3+5;
		 			
				// Set stroke-color white
				stroke(0);    
				strokeWeight(2); // Thicker
				line(x,y,x2,y);     
				line(x,y2,x2,y2);    
			} 
			else if(bt.type==18)
			{     
				int y=bt.y+5; 
				int y2=0;
				int x=bt.x+22; 
				int x2=x+120;
				 
				y2=y+8;
		 			
				// Set stroke-color white
				stroke(0);    
				strokeWeight(4); // Thicker
				line(x,y,x2,y);     
				line(x,y2,x2,y2);  
			}
			else if(bt.type>=21 && bt.type<=25)
			{    
				int y1=0; 
				int y2=0; 
				int x1=0; 
				int x2=0;
				for(int a=0;a<blist.size();a++)
				{
					BloodType tmp_bt=(BloodType)blist.get(a);
					if(tmp_bt.type==11 || tmp_bt.type==12)
					{
						y1=bt.y+11; 
						y2=y1+8; 
						break;
					}
					else if(tmp_bt.type>=13 && tmp_bt.type<16)
					{
						y1=bt.y+5; 
						y2=y1+8;
						break;
					} 
					else if(tmp_bt.type>=16 && tmp_bt.type<=18)
					{
						y1=bt.y+1; 
						y2=y1+8;
						break;
					}
				}
				
				if(y1>0)
				{ 
					for(int a=21;a<=bt.type;a++)
					{
						x1=bt.x+25+(a-21)*4; 
						x2=x1+3; 
						// Set stroke-color white
						stroke(0);    
						strokeWeight(2); // Thicker
						line(x1,y1,x2,y2); 
					}
				}
			}
			else if(bt.type==31)
			{     
				int y=bt.y+6; 
				int x=bt.x+110;
				
				x=x-(bt.group_size-group_idx)*23;
				
				int y2=y+17; 
				int x2=x+18; 
		 			
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				line(x,y,x2,y);     
				line(x,y2,x2,y2);
				arc(x+9,y+8,8,16,0,TWO_PI);
				group_idx++;    
			}
			else if(bt.type==32)
			{     
				int y=bt.y+22; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*23;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				arc(x,y,22,22,PI,TWO_PI); 
				arc(x,y,10,10,PI,TWO_PI);
				group_idx++;        
			}
			else if(bt.type==33)
			{     
				int y=bt.y+22; 
				int x=bt.x+110; 
				x=x-(bt.group_size-group_idx)*23;
				
				int x2=x+5;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				line(x,y,x,y-12); 
				line(x+22,y,x+22,y-12);  
				line(x,y-12,x+21,y-12); 
				line(x2,y,x2,y-6); 
				line(x2+12,y,x2+12,y-6);  
				line(x2,y-6,x2+11,y-6);  
				group_idx++;        
			} 
			else if(bt.type==34)
			{     
				int y=bt.y+15; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*26;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				arc(x,y,10,10,0,PI+(PI*1/5));  
				arc(x+10,y,10,10,PI,TWO_PI+(PI*1/5)); 
				group_idx++;        
			}
			else if(bt.type==35)
			{     
				int y=bt.y+15; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*23;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				arc(x,y,15,10,0,TWO_PI);
				line(x-2,y-3,x-5,y+3);  
				line(x+1,y-3,x-1,y+3);  
				line(x+2,y+3,x+5,y-3); 
				group_idx++;        
			} 
			else if(bt.type==36)
			{     
				int y=bt.y+15; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*23;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				
				line(x-7,y+5,x-2,y-5);
				line(x-2,y-5,x+2,y+5); 
				line(x+2,y+5,x+7,y-5);   	
				group_idx++;        
			}  
			else if(bt.type==37)
			{     
				int y=bt.y+15; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*23;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				arc(x,y,13,13,0,TWO_PI); 
				arc(x,y,8,8,0,TWO_PI);
				group_idx++;        
			} 
			else if(bt.type==38)
			{     
				int y=bt.y+15; 
				int x=bt.x+120; 
				x=x-(bt.group_size-group_idx)*23;
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	
				arc(x,y,13,13,0,TWO_PI);  
				line(x-4,y-4,x+4,y+4);    
				line(x-4,y+4,x+4,y-4);
				group_idx++;        
			}  
			else if(bt.type==39)
			{     
				int y=bt.y+6; 
				int x=bt.x+110;
				
				x=x-(bt.group_size-group_idx)*23;
				
				int y2=y+17; 
				int x2=x+18; 
		 			
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				line(x-3,y,x2,y);     
				line(x-3,y2,x2,y2);
				arc(x+9,y+8,8,16,0,TWO_PI);
				line(x-2,y-2,x,y+2);  
				line(x+2,y-2,x+4,y+2);  
				line(x-2,y2-2,x,y2+2);  
				line(x+2,y2-2,x+4,y2+2);
				group_idx++;        
			}     
			else if(bt.type==40)
			{     
				int y=bt.y+17; 
				int x=bt.x+120;
				
				x=x-(bt.group_size-group_idx)*23;
				
				int x2=x+18; 
		 			
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				line(x,y,x2,y);  
				strokeWeight(3); 
				point(x+9,y-4); 
				point(x+9,y+4);
				
				group_idx++;        
			}
			else if(bt.type==41)
			{     
				int y=bt.y+15; 
				int x=bt.x+120;
				
				x=x-(bt.group_size-group_idx)*23;
		 			
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				arc(x,y,12,12,0,TWO_PI);
				line(x-3,y-1,x-1,y+1);  
				line(x+1,y-1,x+3,y+1);  
				group_idx++;        
			}  
			else if(bt.type==51)
			{     
				int y=bt.y+27; 
				int x=bt.x+150; 
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x-1,y,x+1,y-10);         
				arc(x-2,y-9,4,4,PI,TWO_PI); 
				arc(x+6,y-5,10,10,PI,TWO_PI);           
				line(x+12,y,x+11,y-5);      
			}  
			else if(bt.type==52)
			{     
				int y=bt.y+5; 
				int x=bt.x+150; 
		 		
		 		//window.console.log("x:"+x+",y:"+y); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x-1,y,x+1,y+2);        
				line(x+4,y,x+6,y+2);        
			} 
			else if(bt.type==61)
			{     
				int idx=(int)(bt.idx/5);
				int x=0; 
				int y=0;   
				int len=10;  
				int w=-20;
				int w2=w+len+10; 
				int w3=w2+len+10;
				   
				x=50+area_space*(idx%3);
				
				if((idx/3)>=1)
				{          
					y=320-10;
				}
				else
				{    
					y=50-10;
				}
				
				//window.console.log("bt.idx:"+bt.idx+",idx:"+idx+",x:"+x+",y:"+y+",group_size:"+bt.group_size+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w+len,y);        
				line(x+w+len,y,x+w+len-5,y-3);      
				line(x+w+len,y,x+w+len-5,y+3);  
				line(x+w2,y,x+w2+len,y);        
				line(x+w2+len,y,x+w2+len-5,y-3);      
				line(x+w2+len,y,x+w2+len-5,y+3); 
				line(x+w3,y,x+w3+len,y);        
				line(x+w3+len,y,x+w3+len-5,y-3);      
				line(x+w3+len,y,x+w3+len-5,y+3); 
			}  
			else if(bt.type==62)
			{     
				int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+25;   
				int len=10;  
				int w=-20;
				int w2=w+len+10; 
				int w3=w2+len+10;  
				   
				x=50+area_space*(idx%3);
				
				if((idx/3)>=1)
				{          
					y=320-10;
				}
				else
				{     
					y=50-10;
				}
				
		 		//window.console.log("bt.idx:"+bt.idx+",idx:"+idx+",x:"+x+",y:"+y+",group_size:"+bt.group_size+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w+4,y);        
				line(x+w+10,y,x+w+14,y);         
				line(x+w2,y,x+w2+4,y);         
				line(x+w2+10,y,x+w2+14,y);        
				line(x+w3,y,x+w3+len,y);        
				line(x+w3+len,y,x+w3+len-5,y-3);      
				line(x+w3+len,y,x+w3+len-5,y+3);          
			}
			else if(bt.type==63)
			{     
				int idx=(int)(bt.idx/5);
				int x=0; 
				int y=0;   
				int len=10;  
				int w=-20;
				int w2=w+len+10; 
				int w3=w2+len+10;
				   
				x=50+area_space*(idx%3);
				
				if((idx/3)>=1)
				{          
					y=320-10;
				}
				else
				{    
					y=50-10;
				}
				
				//window.console.log("bt.idx:"+bt.idx+",idx:"+idx+",x:"+x+",y:"+y+",group_size:"+bt.group_size+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w+len,y);        
				line(x+w+len,y,x+w+len-5,y-3);      
				line(x+w+len,y,x+w+len-5,y+3);  
				line(x+w2,y,x+w2+len,y);        
				line(x+w2+len,y,x+w2+len-5,y-3);      
				line(x+w2+len,y,x+w2+len-5,y+3); 
				line(x+w3,y,x+w3+len,y);        
				line(x+w3+len,y,x+w3+len-5,y-3);      
				line(x+w3+len,y,x+w3+len-5,y+3);
				arc(x+6,y,61,17,0,TWO_PI);    
			}   
			else if(bt.type==71)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7);        
			}  
			else if(bt.type==72)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7);  
				w=w+7;
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7);        
			}  
			else if(bt.type==73)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7);
				w=w+7;
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7); 
				w=w+7;
				line(x+w,y,x+w,y-12);        
				line(x+w,y-12,x+w-3,y-7);     
				line(x+w,y-12,x+w+3,y-7);         
			} 
			else if(bt.type==74)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);        
			}  
			else if(bt.type==75)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);
				w=w+7;     
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);       
			}
			else if(bt.type==76)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+27;   
				int len=10;  
				int w=180;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);   
				w=w+7;     
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);  
				w=w+7;     
				line(x+w,y,x+w,y-12);        
				line(x+w,y,x+w-3,y-5);     
				line(x+w,y,x+w+3,y-5);       
			}   
			else if(bt.type==81)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+37;   
				int w=20;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y,x+w-10,y-6);        
				line(x+w,y,x+w+10,y-6);        
			}
			else if(bt.type==82)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+35;   
				int w=20;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w-2,y-6,x+w-2,y+3);        
				line(x+w+2,y-6,x+w+2,y+3);        
			}
			else if(bt.type==83)
			{     
				//int idx=(int)(bt.idx/5);
				int x=bt.x; 
				int y=bt.y+37;   
				int w=20;
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x+w,y-6,x+w-10,y);        
				line(x+w,y-6,x+w+10,y);        
			}
			else if(bt.type==91)
			{     
				int idx=(int)(bt.idx/15);
				int x=10;  
				int x2=770; 
				int y=0;   
				int w=0;
				
				if(idx==0)
				{
				    y=140;
                }
                else if(idx==1)
				{
				    y=410;
                }
				
		 		//window.console.log("idx:"+idx+",x:"+x+",w:"+w+",w2:"+w2+",w3:"+w3); 
				// Set stroke-color black
				stroke(0);    
				strokeWeight(2); // Thicker
				noFill();
				 	                        
				line(x,y,x+10,y-10);       
				line(x,y,x+10,y+10);        
				line(x2,y,x2-10,y-10);       
				line(x2,y,x2-10,y+10);           
			}
		}
	}
}

void addPulseType(int ptype) {
	bgDraw();
	if(areaSelectIdx==-1)
	{
		return;
	}      
	ArrayList blist=(PulseArea)bloodList.get(areaSelectIdx);
	//window.console.log("areaSelectIdx:"+areaSelectIdx+",ptype:"+ptype+",blist.size():"+blist.size());
	if(blist.size()>0)
	{ 
		for(int i = blist.size()-1; i >= 0; i--)
		{   
			BloodType bt=(BloodType)blist.get(i);
			int p1=(int)(bt.type/10);    
			int p2=(int)(ptype/10);
			//window.console.log("p1:"+p1+",p2:"+p2);
			if(ptype==bt.type)
			{   
				blist.remove(i);
				mouseMoved();
				return;
			}
			else if(p1==p2)
			{          
				blist.remove(i);
			} 
		}
	} 
	for(int i=0;i<pareaList.size();i++)
	{                 
		PulseArea parea=(PulseArea)pareaList.get(i);           
  		if(parea.idx==areaSelectIdx) 
		{                
			//window.console.log("parea.idx:"+parea.idx);
  			BloodType bt=new BloodType();  
			bt.x=parea.x;
			bt.y=parea.y; 
			bt.h=parea.h;
			bt.w=parea.w; 
			bt.idx=parea.idx;
			bt.type=ptype;
			bt.group_size=0;
			blist.add(bt);
		}
	}
	mouseMoved();	
}
 
void addLongPulseType(int ptype) {
	bgDraw();
	if(areaSelectIdx==-1)
	{
		return;
	}
	int areaID=(int)(areaSelectIdx/15);
	int findId=0;
    //check before LongPulse area
	for(int i=(areaID*15);i<(areaID+1)*15;i++)
	{                     
		ArrayList blist=(ArrayList)bloodList.get(i); 
		for(int j = blist.size()-1; j >= 0; j--)
		{   
			BloodType bt=(BloodType)blist.get(j);  
			int areaIDtmp=(int)(bt.idx/15);    
			//window.console.log("p1:"+p1+",p2:"+p2);
			if(bt.type==91 && areaIDtmp==areaID )
			{   
				blist.remove(j); 
				mouseMoved();
				return;
			} 
		}
	}
    //add LongPulse 
	ArrayList blist=(PulseArea)bloodList.get(areaSelectIdx);
	for(int i=0;i<pareaList.size();i++)
	{                 
		PulseArea parea=(PulseArea)pareaList.get(i);           
  		if(parea.idx==areaSelectIdx) 
		{                
			//window.console.log("parea.idx:"+parea.idx);
  			BloodType bt=new BloodType();  
			bt.x=parea.x;
			bt.y=parea.y; 
			bt.h=parea.h;
			bt.w=parea.w; 
			bt.idx=parea.idx;
			bt.type=ptype;
			bt.group_size=0;
			blist.add(bt);
		}
	} 
	mouseMoved();
}
 
void addFastPulseType(int ptype) {
	bgDraw();
	if(areaSelectIdx==-1)
	{
		return;
	}
	int areaID=(int)(areaSelectIdx/5);
	int findId=0;
    //check before LongPulse area
	for(int i=(areaID*5);i<(areaID+1)*5;i++)
	{                     
		ArrayList blist=(ArrayList)bloodList.get(i); 
		for(int j = blist.size()-1; j >= 0; j--)
		{   
			BloodType bt=(BloodType)blist.get(j);  
			int areaIDtmp=(int)(bt.idx/5);  
			int typeIDtmp=(int)(bt.type/10);       
			//window.console.log("addFastPulseType()i:"+i+",j:"+j+",bt.type:"+bt.type+",ptype:"+ptype+"areaIDtmp:"+areaIDtmp+",areaID:"+areaID);
			if(bt.type==ptype && areaIDtmp==areaID )
			{   
				blist.remove(j);
				findId=1; 
				mouseMoved();
				return;
			}
			else if(typeIDtmp==6)
			{    
				blist.remove(j); 
			} 
		}
	}
    //add Pulse 
	ArrayList blist=(PulseArea)bloodList.get(areaSelectIdx);
	for(int i=0;i<pareaList.size();i++)
	{                 
		PulseArea parea=(PulseArea)pareaList.get(i);           
  		if(parea.idx==areaSelectIdx) 
		{                
			//window.console.log("parea.idx:"+parea.idx);
  			BloodType bt=new BloodType();  
			bt.x=parea.x;
			bt.y=parea.y; 
			bt.h=parea.h;
			bt.w=parea.w; 
			bt.idx=parea.idx;
			bt.type=ptype;
			bt.group_size=0;
			blist.add(bt);
		}
	} 
	mouseMoved();
}

void addPulseTypeGroup(int ptype) {
	bgDraw();
	if(areaSelectIdx==-1)
	{
		return;
	}
	int findId=0;
	int group_size=0; 
	int group_slow_fast_size=0;      
	ArrayList blist=(PulseArea)bloodList.get(areaSelectIdx);
	//window.console.log("areaSelectIdx:"+areaSelectIdx+",ptype:"+ptype+",blist.size():"+blist.size());
	//count before BloodType group size
	if(blist.size()>0)
	{                               
		for(int i = blist.size()-1; i >= 0; i--)
		{   
			BloodType bt=(BloodType)blist.get(i);  
			int p1=(int)(bt.type/10);    
			int p2=(int)(ptype/10);
			//window.console.log("p1:"+p1+",p2:"+p2);
			if(ptype==bt.type)
			{   
				blist.remove(i);
				findId=1;
			}
			else if(bt.type>30 && bt.type<50)
			{          
				group_size++;
			}
			else if(bt.type>60 && bt.type<70)
			{          
				group_slow_fast_size++;
			} 
		}
	}
	//add new BloodType and set group size
	if(findId==0)
	{
		for(int i=0;i<pareaList.size();i++)
		{                 
			PulseArea parea=(PulseArea)pareaList.get(i);           
	  		if(parea.idx==areaSelectIdx) 
			{         
                if(ptype>30 && ptype<50)
		        {          
				    group_size++;
                }
                else if(ptype>60 && ptype<70)
                {          
				    group_slow_fast_size++;
                }          
			     
				//window.console.log("parea.idx:"+parea.idx);
	  			BloodType bt=new BloodType();
				bt.x=parea.x;
				bt.y=parea.y; 
				bt.h=parea.h;
				bt.w=parea.w; 
				bt.idx=parea.idx;
				bt.type=ptype;
				if(ptype>60 && ptype<70)
				    bt.group_size=group_slow_fast_size;
				else if(ptype>30 && ptype<50)
				    bt.group_size=group_size;
				blist.add(bt);
			}
		}
	}       
	//count before BloodType and set new group size
	for(int i = blist.size()-1; i >= 0; i--)
	{   
		BloodType bt=(BloodType)blist.get(i);  
		int p1=(int)(bt.type/10);    
		int p2=(int)(ptype/10);
		//window.console.log("p1:"+p1+",p2:"+p2);
		if(bt.type>30 && bt.type<50)
		{     
			bt.group_size=group_size;
			blist.remove(i);   
			blist.add(bt);  
		}
		else if(bt.type>60 && bt.type<70)
		{     
			bt.group_size=group_slow_fast_size;
			blist.remove(i);   
			blist.add(bt);  
		} 
	}
	mouseMoved();	
}

void cancelPulse()
{    
	bgDraw();
	if(areaSelectIdx==-1)
	{
		return;
	} 
	ArrayList blist=(PulseArea)bloodList.get(areaSelectIdx);if(blist.size()>0)
	{ 
		for(int i = blist.size()-1; i >= 0; i--)
		{   
			blist.remove(i);
		}
	} 
	mouseMoved();
}

String getPulseObj()
{            
	String str="";
    for(int i=0;i<bloodList.size();i++)
	{                     
		ArrayList blist=(ArrayList)bloodList.get(i);    
		       
		for(int j = blist.size()-1;j>= 0;j--)
		{   
			BloodType bt=(BloodType)blist.get(j);
			str+=bt.idx+":"+bt.type+"@";
		}
	}
	//window.console.log("getPulseObj():"+str);
	return str;
}    