from zk import ZK, const
import sys

host = sys.argv[len(sys.argv)-1]

conn = None
# create ZK instance
zk = ZK(host, port=4370, timeout=5, password=0, force_udp=False, ommit_ping=False)
try:
        sys.stdout.write ('idDevice')
        sys.stdout.write (str(';'))
        sys.stdout.write ('id')
        sys.stdout.write (str(';'))
        sys.stdout.write ('userPrivilege')
        sys.stdout.write (str(';'))
        sys.stdout.write ('userName')
        sys.stdout.write (str(';'))
        sys.stdout.write ('userPassword')
        sys.stdout.write (str(';'))
        sys.stdout.write ('idGroup')
        sys.stdout.write (str(';'))
        sys.stdout.write ('idUser')
        sys.stdout.write (str('\n'))

        conn = zk.connect()
        conn.disable_device()
        serial = conn.get_serialnumber();
        users = conn.get_users()
        for user in users:
                sys.stdout.write (serial)
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.uid))
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.privilege))
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.name))
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.password))
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.group_id))
                sys.stdout.write (str(';'))
                sys.stdout.write (str(user.user_id))
                sys.stdout.write (str('\n'))
        conn.enable_device()

        sys.exit(0)
except Exception as e:
        print ("Process terminate : {}".format(e))
        sys.exit(1)
finally:
        if conn:
                conn.disconnect()
