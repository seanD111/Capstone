clear variables;
load('clipInfos.mat')
windowHop=0.010;
 % Read in an mp3 file, downsampled to 22 kHz mono
 [d_twochan,sr] = audioread(clipsStruct(415).name);
 d=d_twochan(:, 1);
 t=windowHop:1/sr:((length(d)-1))/sr;
 soundsc(d,sr)
 % Convert to MFCCs very close to those genrated by feacalc -sr 22050 -nyq 8000 -dith -hpf -opf htk -delta 0 -plp no -dom cep -com yes -frq mel -filt tri -win 32 -step 16 -cep 20
 [mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', sr/2, 'numcep', 13, 'nbands', 26, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.025, 'hoptime', 0.01, 'preemph', 0, 'dither', 0);
 % .. then convert the cepstra back to audio (same options)
 [im,ispc] = invmelfcc(mm, sr, 'maxfreq', sr/2, 'numcep', 13, 'nbands', 26, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.025, 'hoptime', 0.01, 'preemph', 0, 'dither', 0);
 % listen to the reconstruction
 soundsc(im,sr)
 % compare the spectrograms
 subplot(311)
 axis('tight')
 specgram(d,512,sr)
 caxis([-50 30])
 title('original music')
 subplot(312)
 axis('tight')
 specgram(im,512,sr)
 caxis([-40 40])
 title('noise-excited reconstruction from cepstra')
 % Notice how spectral detail is blurred out e.g. the triangle hits around 6 kHz are broadened to a noise bank from 6-8 kHz.
 % save out the reconstruction
subplot(313)
plot(t, d(windowHop*sr : end-1, 1))
axis('tight')
y=predictionTest3(mm);
Ymean=mean(y');
%[highest, decision]=max(Ysum)