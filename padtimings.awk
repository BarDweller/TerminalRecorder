BEGIN {
  FS=" ";
  LASTTIME=0.0;
  LASTCOUNT=0;
}

{
  CURRENTTIME=$1;
  CURRENTCOUNT=$2;

  if(NR==1){
    print "4.000000 1"; 
  }
  else if(NR==2){
    REDUCED=LASTCOUNT-1;
    printf("%06f %d\n", LASTTIME, REDUCED);
  }
  else{
    printf("%06f %d\n", LASTTIME, LASTCOUNT);
  } 
  
  LASTTIME=CURRENTTIME;
  LASTCOUNT=CURRENTCOUNT;
}

END {
  REDUCED=LASTCOUNT-1;
  printf("%06f %d\n", LASTTIME, REDUCED);
  print "8.000000 1"; 
}
