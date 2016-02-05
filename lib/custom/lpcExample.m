seg=speech(1:160);

wseg=seg.*hamming(160);

a=lpc(wseg,10);