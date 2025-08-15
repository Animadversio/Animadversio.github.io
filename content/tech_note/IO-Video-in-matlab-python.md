## Motivation

This note is related to [the dynamic visualization note]({{< relref "Dynamic-Visualization-in-Python.md" >}}) . Sometimes we want to export a movie or animation from matlab or python. Here summarize some common code clips. 

## Matlab

### GIF





### Others: MOV AVI MP4 etc

Note GIF is less compressed so it's often huge comparing to other formats. 

So for outputing lots of movies please use AVI. `VideoWriter`

```matlab
if option.save
v = VideoWriter(fullfile(savedir,compose("%s_%s_Exp%d_%s_cc_%s.avi",Animal,ExpType,Expi,layername,Meanstr)));
v.FrameRate = 2;open(v);
fprintf("Writing video to %s\n",fullfile(savedir,compose("%s_%s_Exp%d_%s_cc_%s.avi",Animal,ExpType,Expi,layername,Meanstr)))
end
CMIN = prctile(plot_tsr, [ 2], 'all');
CMAX = prctile(plot_tsr, [98], 'all'); 
figure(18);set(18,'Position',[0   435   552   543])
IMS = imagesc(plot_tsr(:,:,1));axis image
caxis([CMIN,CMAX]);colorbar;
for fi = 1:size(plot_tsr,3)
    wdw = wdw_vect(fi,:); % [1, 20] + 10 * (fi - 1); 
    IMS.CData = plot_tsr(:,:,fi);
    IMS.Parent.Title.String = sprintf("%s %s Exp %d Pref chan %d\n %s CorreCoef in of VGG16 %s feature\n with [%d,%d] ms firing rate", ...
            Animal, ExpType, Expi, EStats(Expi).units.pref_chan, Meanstr, layername, wdw(1), wdw(2));
    pause(0.2)
    Fs = getframe(18);
    if option.save, writeVideo(v,Fs); end
    drawnow;
end
if option.save, close(v); end
```



## Python

https://www.learnopencv.com/read-write-and-display-a-video-using-opencv-cpp-python/

### Getframe like matlab

This is a small useful trick just like matlab. It can save figures as frames and 

```python
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.animation import FFMpegWriter

metadata = dict(title='Movie Test', artist='Matplotlib',
                comment='Movie support!')
writer = FFMpegWriter(fps=15, metadata=metadata)
fig = plt.figure()
l, = plt.plot([], [], 'k-o')

plt.xlim(-5, 5)
plt.ylim(-5, 5)

x0, y0 = 0, 0
with writer.saving(fig, "writer_test.mp4", 100):
    for i in range(100):
        x0 += 0.1 * np.random.randn()
        y0 += 0.1 * np.random.randn()
        l.set_data(x0, y0)
        writer.grab_frame()
```

https://www.sfn.org/meetings/neuroscience-2020/abstracts/call-for-abstracts



### Matplotlib.animation

This is useful when you want to animate a **Figure** or axes. It has 2 major classes, artist animation and function animation

For artist animation, you construct a list of list. In each sublist, it contains a group of `Artist` objects to show together. So note that the title and the figure can be different artists. 

```python
img = [] # some array of images
frames = [] # for storing the generated images
fig = plt.figure()
for i in xrange(6):
	im = plt.imshow(img[i], cmap=cm.Greys_r,animated=True)
    frames.append([im])

anim = animation.ArtistAnimation(fig, frames, interval=200, blit=True, repeat_delay=1000)
anim.save('movie.mp4')
plt.show()
```

This method has a known issue that axes title will not change through out animation! You need to use `text` instead. 

```python
fig, ax = plt.subplots()
ims=[]

for iternum in range(4):
    title = plt.text(0.5,1.01,iternum, ha="center",va="bottom",color=np.random.rand(3),
        transform=ax.transAxes, fontsize="large")
    text = ax.text(iternum,iternum,iternum)
    scatter = ax.scatter(np.random.randint(0,10,5), np.random.randint(0,20,5),marker='+')
    ims.append([text,scatter,title,])


ani = animation.ArtistAnimation(fig, ims, interval=500, blit=False, repeat_delay=2000)
```

https://stackoverflow.com/questions/47421486/matplotlib-artist-animation-title-or-text-not-changing

In contrast, **function animation** is very easy to update title. In its essence, you write an update function to change the figure using the iteration number. And then send the function to `animation.FuncAnimation` . 

```python
VMIN, VMAX = np.percentile(ThrL1_data,[2,98])
fig, ax = plt.subplots()
ccmap = ax.imshow(ThrL1_data[:, :, 10],vmin=VMIN,vmax=VMAX)
Title = ax.set_title("Rate [1, 20]ms")
plt.colorbar(ccmap)

def update(fi):
    wdw = wdw_vect[fi,:]
    ccmap.set_data(ThrL1_data[:, :, fi])
    Title.set_text("Rate [%d, %d]ms"%(wdw[0], wdw[1]))
    plt.pause(0.2)
    clear_output(wait=True)
    display(fig)

anims = animation.FuncAnimation(fig, update, frames=cc_tsr.shape[-1], interval=200, blit=False,
                              repeat_delay=2000)
anims.save('Beto_Manif_Exp11_conv4-3_2.mp4')
plt.show()
```



### cv2.VideoWriter

This is useful when you want to animate a sequence of images







### Matplotlib Export

(This seems irrelevant here. Grab frame is much easier. )

```python
fig = Figure()
# attach a non-interactive Agg canvas to the figure
# (as a side-effect of the ``__init__``)
canvas = FigureCanvas(fig)
ax = fig.subplots()
ax.plot([1, 2, 3])
ax.set_title('a simple figure')
# Force a draw so we can grab the pixel buffer
canvas.draw()
# grab the pixel buffer and dump it into a numpy array
IMG = np.array(canvas.renderer.buffer_rgba())
```







