https://zhuanlan.zhihu.com/p/33834336



## Environment for Agents

OpenAI GYM provides an environment for testing algorithms, and it interfaces with many famous test problems like 

* Physical control
* Atari
* Mojuco

https://github.com/openai/gym/issues/1726#issuecomment-550580367

https://zhuanlan.zhihu.com/p/33834336

https://github.com/Kojoley/atari-py

```bash
pip install --no-index -f https://github.com/Kojoley/atari-py/releases atari_py
pip install gym
```



### MoJuCo

https://web.stanford.edu/class/cs234/assignment3/mujoco_win_install.pdf

http://www.mujoco.org/book/

![image-20200816002350054](E:\Animadversio.github.io\assets\img\notes\rl\image-20200816002350054.png)



Note seems older versions of `gym` + older version of `MuJoCo` + older version of `mujoco_py` will be compatible. For example 

> mujoco：131
> mujoco_py:0.5.7
> tensorflow:1.5.0
> gym:0.9.1
> python3.6
>
> but you may need to use the order version of environment models in mujoco platform.
> (eg. you have to use 'InvertedPendulum-v1' in stead of the higher version'InvertedPendulum-v2')
> Good luck~

You may need to resolve some error using it. 

```bash
pip install gym==0.9.1 --use-feature=2020-resolver
```

https://github.com/openai/mujoco-py/issues/261

## Test Rendering

https://www.endtoend.ai/envs/gym/mujoco/

```python
import gym
env = gym.make('Humanoid-v2')
env.reset()
env.render()
```

```python
observation = env.reset()
for t in range(100):
	env.render()
	print(observation)
	action = env.action_space.sample()
	observation, reward, done, info = env.step(action)
	if done:
		print("Episode finished after {} timesteps".format(t+1))
		break
```

### Build Models in Mujoco

https://studywolf.wordpress.com/2020/03/22/building-models-in-mujoco/