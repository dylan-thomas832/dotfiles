# Timestamp function
timestamp () {
    python -c 'TIMESTAMP_FORMAT="%d-%m-%Y_%H-%M-%S";import time;print(time.strftime(TIMESTAMP_FORMAT, time.gmtime()))'
}
