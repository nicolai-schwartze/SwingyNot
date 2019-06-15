# -*- coding: utf-8 -*-
"""
Created on Sat Jun 15 05:06:42 2019

@author: Nicolai
----------------
"""
import sys
sys.path.append("PythonModules/")
import callDymolaSimulation as dymolaPY
import DE_Modules as dem
import numpy as np

if __name__ == "__main__":
    dymolaPY.createDymosimExe("SwingyNot.ModelSwingyNotDouble", 2)
    dim = 10
    popsize = 20
    simplePath = np.linspace(0.01,0.99,dim)
    population = simplePath
    lowerConstraint = [(-1)*0.1 for i in range(dim)]
    upperConstraint = [0.1 for i in range(dim)]
    for i in range(popsize-1):
        tempPath = simplePath + np.random.uniform(lowerConstraint, upperConstraint, size=(1,dim))
        population = np.vstack([population, tempPath])
        
    stoppingCond = {"maxEval": 100000, "minF": 5*10**(-8), "minVar": 1e-10, "maxGen": 100}
    result = dem.DE_x_y_z(population, dem.crossoverBIN, dem.mutationCurrentToBest1, dymolaPY.evaluateSimulation2DDouble, 0, np.identity(dim), stoppingCond, F=0.5, CR=0.2)
    