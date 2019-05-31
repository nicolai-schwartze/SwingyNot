# -*- coding: utf-8 -*-
"""
Created on Fri May 31 09:15:31 2019

@author: Nicolai
----------------
"""

import sys
sys.path.append('C:\Program Files\Dymola 2019 FD01\Modelica\Library\python_interface\dymola.egg')

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
        result = dymola.simulateExtendedModel('ModelSwingyNot', stopTime=10.0)
        
        if not result:
            print("Simulation failed. Below is the translation log.")
            log = dymola.getLastErrorLog()
            print(log)
            exit(1)
            
    
    except DymolaException as ex:
        print(("Error: " + str(ex)))
    finally:
        if dymola is not None:
            dymola.close()
            dymola = None
            
if __name__ == "__main__":
    simulation2DPendulum()