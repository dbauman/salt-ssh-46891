# Build
```
$ docker build -t salt-ssh-46891 .
...
Successfully built 346e17998383
Successfully tagged salt-ssh-46891:latest
```

# Run
```
$ docker run -it --rm salt-ssh-46891
```

# Error 1
```
[master@b3367c94af10 ~]$ salt-ssh -i dummy state.apply testfile
[ERROR   ] An Exception occurred while executing state.apply: [Errno 13] Permission denied: '/home/minion/salt-deploy'
dummy:
    An Exception occurred while executing state.apply: [Errno 13] Permission denied: '/home/minion/salt-deploy'
```

# Error 2
```
[master@b3367c94af10 ~]$ salt-ssh -i dummy state.apply localtest
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    [CRITICAL] Unable to make cachedir /home/minion/salt-deploy/running_data/var/cache/salt/minion/file_lists/roots
    dummy:
    ----------
              ID: run_test
        Function: cmd.run
            Name: id -un
          Result: True
         Comment: Command "id -un" run
         Started: 19:05:48.060248
        Duration: 8.273 ms
         Changes:   
                  ----------
                  pid:
                      203
                  retcode:
                      0
                  stderr:
                  stdout:
                      root

    Summary for dummy
    ------------
    Succeeded: 1 (changed=1)
    Failed:    0
    ------------
    Total states run:     1
    Total run time:   8.273 ms
```
