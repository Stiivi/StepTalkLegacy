" Notification example 
  
  Show usage of NSNotification class and notification handling in scripts

"
[|

" Main script method "
main
    | center |

    center := NSNotificationCenter defaultCenter.

    Transcript showLine:'Registering for notification.'.

    center addObserver:self 
          selector:#handleNotification: 
              name:'Notification' object:nil.

    Transcript showLine:'Posting notification.'.

    center postNotificationName:'Notification' object:nil.
    
    ^self
!

" Method as notification handler "
handleNotification:notif
    
    Transcript showLine:'Notification received.'.

    ^self

]
