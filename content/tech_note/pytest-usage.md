



## Motivation for PyTest

Each test file can share local variables in that script. 



In PyCahrm you can configure test setting in `Python integrated tools>testing`  

### PyTest Fixture

Some components are shared among multiple tests (like a neural network), we can use a fixture to initialize it for all the tests. 

The following is a coding pattern that is quite useful for this. 

```python
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

@pytest.fixture
def inceptionv1_model():
    model = inceptionv1().to(device).eval()
    return model

def assert_gradient_descent(objective, model):
    params, image = param.image(224, batch=2)
    optimizer = torch.optim.Adam(params, lr=0.05)
    T = render.hook_model(model, image)
    objective_f = objectives.as_objective(objective)
    model(image())
    start_value = objective_f(T)
    for _ in range(NUM_STEPS):
        optimizer.zero_grad()
        model(image())
        loss = objective_f(T)
        loss.backward()
        optimizer.step()
    end_value = objective_f(T)
    assert start_value > end_value


def test_neuron(inceptionv1_model):
    objective = objectives.neuron("mixed3a_1x1_pre_relu_conv", 0)
    assert_gradient_descent(objective, inceptionv1_model)
```

Fixture could also be used to perform parametrized tests! 