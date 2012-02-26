[|

main
    |center|

    center := NSDistributedNotificationCenter defaultCenter.

    Transcript showLine:'Registering'.

    center addObserver:self 
              selector:#notification:
                  name:nil
                object:'s'.
                
    NSRunLoop currentRunLoop run.
!

notification:notif
    
    Transcript showLine:'Notification received: ', (notif description).

    ^self

]
