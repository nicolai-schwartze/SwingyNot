# -*- coding: utf-8 -*-
"""
Created on Fri May 31 09:15:31 2019

@author: Nicolai
----------------
"""

import sys, subprocess
import scipy.io
import numpy as np

# Library On Laptop
sys.path.append('C:\Program Files\Dymola 2019 FD01\Modelica\Library\python_interface\dymola.egg')
# Library On PC
sys.path.append('D:\Programme\Dymola2019\Modelica\Library\python_interface\dymola.egg')
    
from dymola.dymola_interface import DymolaInterface
from dymola.dymola_exception import DymolaException

def createDymosimExe(modelPath, stopTime):
    dymola = None
    try:
        dymola = DymolaInterface()
     
        result = dymola.simulateExtendedModel(modelPath, 0.0, stopTime, 0, 0.0, "Dassl", 0.0001, 0.0, None, None, None, ["Result"], True)
        print(result)
        
        if not result[0]:
            print("Simulation failed. Below is the translation log.")
            log = dymola.getLastErrorLog()
            print(log)
 
    except DymolaException as ex:
        print(("Error: " + str(ex)))
        
    finally:
        if dymola is not None:
            dymola.close()
            dymola = None
            
            
def evaluateSimulation2D(path, xshif, M):
    path = np.hstack((np.array([0]), path))
    path = np.hstack((path, np.array([1])))
    path = path.reshape(path.size,1)
    # ToDo:
    # embedd path in first and last position
    time = np.linspace(0,1.5, path.shape[0])
    time = time.reshape(time.size,1)
    path = np.hstack([time,path])   
    # save numpy array to data.mat
    scipy.io.savemat('SwingyNot/Resources/data.mat', {'path': path})
    # execute model without opening console
    si = subprocess.STARTUPINFO()
    si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    #si.wShowWindow = subprocess.SW_HIDE # default
    subprocess.call('dymosim.exe', startupinfo=si)
    # load dsres.mat
    mat = scipy.io.loadmat('dsres.mat')
    # read result
    result = mat["data_2"][58][-1]
    # return result
    return float(result)


def evaluateSimulation2DDouble(path, xshif, M):
    path = np.hstack((np.array([0]), path))
    path = np.hstack((path, np.array([1])))
    path = path.reshape(path.size,1)
    # ToDo:
    # embedd path in first and last position
    time = np.linspace(0,1.5, path.shape[0])
    time = time.reshape(time.size,1)
    path = np.hstack([time,path])   
    # save numpy array to data.mat
    scipy.io.savemat('SwingyNot/Resources/data.mat', {'path': path})
    # execute model without opening console
    si = subprocess.STARTUPINFO()
    si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
    #si.wShowWindow = subprocess.SW_HIDE # default
    subprocess.call('dymosim.exe', startupinfo=si)
    # load dsres.mat
    mat = scipy.io.loadmat('dsres.mat')
    # read result
    result = mat["data_2"][46][-1]
    # return result
    return float(result)


            
if __name__ == "__main__":
    createDymosimExe("SwingyNot.ModelSwingyNot", 2)
    lowerConstraint = [(1)*0 for i in range(19)]
    upperConstraint = [1 for i in range(19)]
    path = np.random.uniform(lowerConstraint, upperConstraint, size=(1,19))
    print(path)
    print(evaluateSimulation2D(path, None, None))
    