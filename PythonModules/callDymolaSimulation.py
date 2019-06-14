# -*- coding: utf-8 -*-
"""
Created on Fri May 31 09:15:31 2019

@author: Nicolai
----------------
"""

import sys

# Library On Laptop
sys.path.append('C:\Program Files\Dymola 2019 FD01\Modelica\Library\python_interface\dymola.egg')
# Library On PC
sys.path.append('D:\Programme\Dymola2019\Modelica\Library\python_interface\dymola.egg')
    
from dymola.dymola_interface import DymolaInterface
from dymola.dymola_exception import DymolaException

def simulation2DPendulum():
    dymola = None
    try:
        # Instantiate the Dymola interface and start Dymola
        dymola = DymolaInterface()
        
        #load model so that it is not translated
        #modelLoaded = dymola.openModel("../SwingyNot/ModelSwingyNot.mo")
    
        # Call a function in Dymola and check its return value
        
        # example works fine
        # result = dymola.simulateExtendedModel("Modelica.Mechanics.Rotational.Examples.CoupledClutches", 0.0, 1.0, 0, 0.0, "Dassl", 0.0001, 0.0, "test3", ["J1.J", "J2.J"], [2, 3], ["J1.w", "J4.w" ], True) 
        
        result = dymola.simulateExtendedModel("ModelSwingyNot", 0.0, 15.0, 0, 0.0, "Dassl", 0.0001, 0.0, None, None, None, ["Result"], True)
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
            
if __name__ == "__main__":
    simulation2DPendulum()