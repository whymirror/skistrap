#include <stdio.h>
#include <stdlib.h>

#include <X11/Xlib.h>
#include "SkOSWindow_Unix.h"

int
main(void)
{
  Display *dpy = XOpenDisplay(NULL);
  int screen = DefaultScreen (dpy);
  unsigned long white = WhitePixel(dpy, screen);
  unsigned long black = BlackPixel(dpy, screen);

  Window win = XCreateSimpleWindow(dpy,
    DefaultRootWindow(dpy),
    50, 50,   // origin
    200, 200, // size
    0, black, // border
    white );  // backgd


  long eventMask = StructureNotifyMask;
  XSelectInput(dpy, win, eventMask);

  XEvent evt;
  do {
    XNextEvent(dpy, &evt);   // calls XFlush
  } while (evt.type != MapNotify);

  SkOSWindow *skwin = new SkOSWindow(dpy, win);

  eventMask = ButtonPressMask|ButtonReleaseMask;
  XSelectInput(dpy,win,eventMask); // override prev
 
  do {
    XNextEvent(dpy, &evt);   // calls XFlush()
  } while (evt.type != ButtonRelease);


  XDestroyWindow( dpy, win );
  XCloseDisplay( dpy );

  return 0;
}
