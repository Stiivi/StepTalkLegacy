" Print available Pasteboard types "
| pb |

Environment loadModule:'AppKit'.

pb := NSPasteboard generalPasteboard.

Transcript showLine: (pb types).
