

## Dataset Handling 



Dataset Class 



Data spliting 

```python
dataset = MNIST(root = './data', train = train, transform = transform, download=True)
train_set, val_set = torch.utils.data.random_split(dataset, [50000, 10000])
```

Data Augmentation and Transform

```python
transform_train = transforms.Compose([
    transforms.RandomCrop(32, padding=4),
    transforms.RandomHorizontalFlip(),
    transforms.ToTensor(),
    transforms.Normalize(rgb_mean, rgb_std),
])

kwargs = {'num_workers': 2, 'pin_memory': True} if args.cuda else {}
train_loader = torch.utils.data.DataLoader(datasets.CIFAR10(root=data_root, train=True, transform=transform_train,
    transforms.Normalize(rgb_mean, rgb_std),
]), download=False), batch_size=128, **kwargs)

```





## Tensorboard Recording

```python
writer = SummaryWriter(log_dir=outdir, flush_secs=180)
for n_iter in range(100):
    writer.add_scalar('Loss/train', np.random.random(), n_iter)
    writer.add_scalar('Loss/test', np.random.random(), n_iter)
    writer.add_scalar('Accuracy/train', np.random.random(), n_iter)
    writer.add_scalar('Accuracy/test', np.random.random(), n_iter)
```

Note on windows, passing multiple run using `--logdir` is not working, so use `--logdir_spec` instead! 



Recording the inner state of network requires to detach them from the network and clone their value. 



## Visualization 

Tensorboard support figures, so making pretty visualization of inner structure of the network and record them throughout training is very useful.



## Learning Rate Scheduling 

Learning rate schedule is important for training! 



## Gradient and Weight Inspection

Inspecting and analyzing gradient in pytorch is super easy, each variable in the computational graph store its gradient in `t.grad`. And this value will not be erased until you perform `optimizer.zero_grad()`. So you could inspect the statistics of gradient during validation phase. 

One useful thing is by inspecting the relative proportion of gradient w.r.t. current weight, you will get a proper scale of learning rate. 

```python
def weight_grad_stats(model):
    for name, submod in model.named_children():
        classname = submod._get_name()
        print(name, classname)
        for subname, subsubmod in submod.named_children():
            subclassname = subsubmod._get_name()
            print('\t', subname, subclassname)
            for param in subsubmod.parameters():
                if param.grad is not None:
                    print("\t\t%s : w %.4E, grad %.4E" % (
                    str(list(param.shape)), param.abs().mean(), param.grad.abs().mean()))
                else:
                    print("\t\t%s : w %.4E, grad not reached" % (str(list(param.shape)), param.abs().mean()))
    return

pwc = PWC_Net(model_path='models/chairs-things.pytorch').cuda()
optimizer = optim.SGD(pwc.parameters(), lr=0.00001, )  # weight_decay=0.0004)
alpha_w = [None, 0.005, 0.01, 0.02, 0.08, 0.32]
optimizer.zero_grad()
im1, im2, trflow = SintelClean[101]
trflow_pyr = resize_pyramid(trflow.unsqueeze(0).cuda())
predflow_pyr = pwc(im1.unsqueeze(0).cuda(), im2.unsqueeze(0).cuda())
loss = loss_fun(FLOW_SCALE * predflow_pyr[5] - trflow_pyr[5 - 1])
loss.backward()
weight_grad_stats(pwc)
```



## Model Summary

https://github.com/Animadversio/pytorch-summary

## Initialization

Weight initialization and reinitialization can be important. 

https://pytorch.org/docs/stable/nn.init.html





