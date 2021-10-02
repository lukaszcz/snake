;; This file contains the system call numbers.

SYS_EXIT                   equ  1
SYS_FORK                   equ  2
SYS_READ                   equ  3
SYS_WRITE                  equ  4
SYS_OPEN                   equ  5
SYS_CLOSE                  equ  6
SYS_WAITPID                equ  7
SYS_CREAT                  equ  8
SYS_LINK                   equ  9
SYS_UNLINK                 equ  10
SYS_EXECVE                 equ  11
SYS_CHDIR                  equ  12
SYS_TIME                   equ  13
SYS_MKNOD                  equ  14
SYS_CHMOD                  equ  15
SYS_LCHOWN                 equ  16
SYS_BREAK                  equ  17
SYS_OLDSTAT                equ  18
SYS_LSEEK                  equ  19
SYS_GETPID                 equ  20
SYS_MOUNT                  equ  21
SYS_UMOUNT                 equ  22
SYS_SETUID                 equ  23
SYS_GETUID                 equ  24
SYS_STIME                  equ  25
SYS_PTRACE                 equ  26
SYS_ALARM                  equ  27
SYS_OLDFSTAT               equ  28
SYS_PAUSE                  equ  29
SYS_UTIME                  equ  30
SYS_STTY                   equ  31
SYS_GTTY                   equ  32
SYS_ACCESS                 equ  33
SYS_NICE                   equ  34
SYS_FTIME                  equ  35
SYS_SYNC                   equ  36
SYS_KILL                   equ  37
SYS_RENAME                 equ  38
SYS_MKDIR                  equ  39
SYS_RMDIR                  equ  40
SYS_DUP                    equ  41
SYS_PIPE                   equ  42
SYS_TIMES                  equ  43
SYS_PROF                   equ  44
SYS_BRK                    equ  45
SYS_SETGID                 equ  46
SYS_GETGID                 equ  47
SYS_SIGNAL                 equ  48
SYS_GETEUID                equ  49
SYS_GETEGID                EQU  50
SYS_ACCT                   EQU  51
SYS_UMOUNT2                EQU  52
SYS_LOCK                   equ  53
SYS_IOCTL                  EQU  54
SYS_FCNTL                  EQU  55
SYS_MPX                    EQU  56
SYS_SETPGID                EQU  57
SYS_ULIMIT                 EQU  58
SYS_OLDOLDUNAME            EQU  59
SYS_UMASK                  EQU  60
SYS_CHROOT                 EQU  61
SYS_USTAT                  EQU  62
SYS_DUP2                   EQU  63
SYS_GETPPID                EQU  64
SYS_GETPGRP                EQU  65
SYS_SETSID                 EQU  66
SYS_SIGACTION              EQU  67
SYS_SGETMASK               EQU  68
SYS_SSETMASK               EQU  69
SYS_SETREUID               EQU  70
SYS_SETREGID               EQU  71
SYS_SIGSUSPEND             EQU  72
SYS_SIGPENDING             EQU  73
SYS_SETHOSTNAME            EQU  74
SYS_SETRLIMIT              EQU  75
SYS_GETRLIMIT              EQU  76
SYS_GETRUSAGE              EQU  77
SYS_GETTIMEOFDAY           EQU  78
SYS_SETTIMEOFDAY           EQU  79
SYS_GETGROUPS              EQU  80
SYS_SETGROUPS              EQU  81
SYS_SELECT                 EQU  82
SYS_SYMLINK                EQU  83
SYS_OLDLSTAT               EQU  84
SYS_READLINK               EQU  85
SYS_USELIB                 EQU  86
SYS_SWAPON                 EQU  87
SYS_REBOOT                 EQU  88
SYS_READDIR                EQU  89
SYS_MMAP                   EQU  90
SYS_MUNMAP                 EQU  91
SYS_TRUNCATE               EQU  92
SYS_FTRUNCATE              EQU  93
SYS_FCHMOD                 EQU  94
SYS_FCHOWN                 EQU  95
SYS_GETPRIORITY            EQU  96
SYS_SETPRIORITY            EQU  97
SYS_PROFIL                 EQU  98
SYS_STATFS                 EQU  99
SYS_FSTATFS                EQU  100
SYS_IOPERM                 EQU  101
SYS_SOCKETCALL             EQU  102
SYS_SYSLOG                 EQU  103
SYS_SETITIMER              EQU  104
SYS_GETITIMER              EQU  105
SYS_STAT                   EQU  106
SYS_LSTAT                  EQU  107
SYS_FSTAT                  EQU  108
SYS_OLDUNAME               EQU  109
SYS_IOPL                   EQU  110
SYS_VHANGUP                EQU  111
SYS_IDLE                   EQU  112
SYS_VM86OLD                EQU  113
SYS_WAIT4                  EQU  114
SYS_SWAPOFF                EQU  115
SYS_SYSINFO                EQU  116
SYS_IPC                    EQU  117
SYS_FSYNC                  EQU  118
SYS_SIGRETURN              EQU  119
SYS_CLONE                  EQU  120
SYS_SETDOMAINNAME          EQU  121
SYS_UNAME                  EQU  122
SYS_MODIFY_LDT             EQU  123
SYS_ADJTIMEX               EQU  124
SYS_MPROTECT               EQU  125
SYS_SIGPROCMASK            EQU  126
SYS_CREATE_MODULE          EQU  127
SYS_INIT_MODULE            EQU  128
SYS_DELETE_MODULE          EQU  129
SYS_GET_KERNEL_SYMS        EQU  130
SYS_QUOTACTL               EQU  131
SYS_GETPGID                EQU  132
SYS_FCHDIR                 EQU  133
SYS_BDFLUSH                EQU  134
SYS_SYSFS                  EQU  135
SYS_PERSONALITY            EQU  136
SYS_AFS_SYSCALL            EQU  137
SYS_SETFSUID               EQU  138
SYS_SETFSGID               EQU  139
SYS__LLSEEK                EQU  140
SYS_GETDENTS               EQU  141
SYS__NEWSELECT             EQU  142
SYS_FLOCK                  EQU  143
SYS_MSYNC                  EQU  144
SYS_READV                  EQU  145
SYS_WRITEV                 EQU  146
SYS_GETSID                 EQU  147
SYS_FDATASYNC              EQU  148
SYS__SYSCTL                EQU  149
SYS_MLOCK                  EQU  150
SYS_MUNLOCK                EQU  151
SYS_MLOCKALL               EQU  152
SYS_MUNLOCKALL             EQU  153
SYS_SCHED_SETPARAM         EQU  154
SYS_SCHED_GETPARAM         EQU  155
SYS_SCHED_SETSCHEDULER     EQU  156
SYS_SCHED_GETSCHEDULER     EQU  157
SYS_SCHED_YIELD            EQU  158
SYS_SCHED_GET_PRIORITY_MAX EQU  159
SYS_SCHED_GET_PRIORITY_MIN EQU  160
SYS_SCHED_RR_GET_INTERVAL  EQU  161
SYS_NANOSLEEP              EQU  162
SYS_MREMAP                 EQU  163
SYS_SETRESUID              EQU  164
SYS_GETRESUID              EQU  165
SYS_VM86                   EQU  166
SYS_QUERY_MODULE           EQU  167
SYS_POLL                   EQU  168
SYS_NFSSERVCTL             EQU  169
SYS_SETRESGID              EQU  170
SYS_GETRESGID              EQU  171
SYS_PRCTL                  EQU  172
SYS_RT_SIGRETURN           EQU  173
SYS_RT_SIGACTION           EQU  174
SYS_RT_SIGPROCMASK         EQU  175
SYS_RT_SIGPENDING          EQU  176
SYS_RT_SIGTIMEDWAIT        EQU  177
SYS_RT_SIGQUEUEINFO        EQU  178
SYS_RT_SIGSUSPEND          EQU  179
SYS_PREAD                  EQU  180
SYS_PWRITE                 EQU  181
SYS_CHOWN                  EQU  182
SYS_GETCWD                 EQU  183
SYS_CAPGET                 EQU  184
SYS_CAPSET                 EQU  185
SYS_SIGALTSTACK            EQU  186
SYS_SENDFILE               EQU  187
SYS_GETPMSG                EQU  188
SYS_PUTPMSG                EQU  189
SYS_VFORK                  EQU  190
SYS_UGETRLIMIT             EQU  191
SYS_MMAP2                  EQU  192
SYS_TRUNCATE64             EQU  193
SYS_FTRUNCATE64            EQU  194
SYS_STAT64                 EQU  195
SYS_LSTAT64                EQU  196
SYS_FSTAT64                EQU  197
SYS_LCHOWN32               EQU  198
SYS_GETUID32               EQU  199
SYS_GETGID32               EQU  200
SYS_GETEUID32              EQU  201
SYS_GETEGID32              EQU  202
SYS_SETREUID32             EQU  203
SYS_SETREGID32             EQU  204
SYS_GETGROUPS32            EQU  205
SYS_SETGROUPS32            EQU  206
SYS_FCHOWN32               EQU  207
SYS_SETRESUID32            EQU  208
SYS_GETRESUID32            EQU  209
SYS_SETRESGID32            EQU  210
SYS_GETRESGID32            EQU  211
SYS_CHOWN32                EQU  212
SYS_SETUID32               EQU  213
SYS_SETGID32               EQU  214
SYS_SETFSUID32             EQU  215
SYS_SETFSGID32             EQU  216
SYS_PIVOT_ROOT             EQU  217
SYS_MINCORE                EQU  218
SYS_MADVISE                EQU  219
SYS_MADVISE1               EQU  219
SYS_GETDENTS64             EQU  220
SYS_FCNTL64                EQU  221
SYS_SECURITY               EQU  223
SYS_GETTID                 EQU  224
SYS_READAHEAD              EQU  225
SYS_SETXATTR               EQU  226
SYS_LSETXATTR              EQU  227
SYS_FSETXATTR              EQU  228
SYS_GETXATTR               EQU  229
SYS_LGETXATTR              EQU  230
SYS_FGETXATTR              EQU  231
SYS_LISTXATTR              EQU  232
SYS_LLISTXATTR             EQU  233
SYS_FLISTXATTR             EQU  234
SYS_REMOVEXATTR            EQU  235
SYS_LREMOVEXATTR           EQU  236
SYS_FREMOVEXATTR           EQU  237
SYS_TKILL                  EQU  238
SYS_SENDFILE64             EQU  239
SYS_FUTEX                  EQU  240
SYS_SCHED_SETAFFINITY      EQU  241
SYS_SCHED_GETAFFINITY      EQU  242
SYS_SET_THREAD_AREA        EQU  243
SYS_GET_THREAD_AREA        EQU  244
SYS_IO_SETUP               EQU  245
SYS_IO_DESTROY             EQU  246
SYS_IO_GETEVENTS           EQU  247
SYS_IO_SUBMIT              EQU  248
SYS_IO_CANCEL              EQU  249
SYS_ALLOC_HUGEPAGES        EQU  250
SYS_FREE_HUGEPAGES         EQU  251
SYS_EXIT_GROUP             EQU  252
