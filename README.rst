################
vLab NTP Service
################

A centralized service for managing system time.

This service uses `chrony <https://chrony.tuxfamily.org/>`_ to synchronize
and time.


*********************
Environment Variables
*********************

- ``VLAB_NTP_SERVER`` - The NTP server to use for synchronizing time.
- ``VLAB_TIMEZONE`` - The local timezone of the vLab server.
