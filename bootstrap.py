import numpy as np

n_bootstraps = 10**4

def bootstrap(data, num_bootstraps=n_bootstraps):
    """Return array of sample means from bootstrapping n_samples times."""
    output = np.zeros(n_bootstraps)
    n = len(data)
    for i in range(n_bootstraps):
        bootstrap_sample = np.random.choice(data, 
                                            size=n,
                                            replace=True)
        output[i] = (bootstrap_sample.sum() / n)
    return output