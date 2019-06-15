# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 10:30:04 2019

@author: Nicolai Schwartze
"""

import numpy as np
import json


class returnClass:
    def __init__(self, errorMessage, opt, fopt, \
                 functionEval, fDynamic, varDynamic, \
                 generationCount, scalarFactor, crossoverRate, \
                 varFitness, population, averageF):
        # string must contain either success or error
        self.errorMessage = errorMessage
        # function value at every function evaluation
        self.fDynamic = fDynamic
        # population variance in search space of length function evaluation
        self.varDynamic = varDynamic
        # best individual with lowest fitness value
        self.opt = opt
        # fitness value of best individual
        self.fopt = fopt
        # number of function evaluations, length of fDynamic and varDynamic
        self.functionEval = functionEval
        # number of generation
        self.generationCount = generationCount
        # scale factor recorded at every generation
        self.scalarFactor = scalarFactor
        # crossover rate at every generation
        self.crossoverRate = crossoverRate
        # population at every generation
        self.population = population
        # average fitness value of the population at every generation
        self.averageF = averageF
        # variance at of fitness value at every generation
        self.varFitness = varFitness
    def wasSuccessful(self):
        if ('success' in self.errorMessage) and ('error' not in self.errorMessage):
            return True
        else:
            return False
        
        
        
def convertReturnClassToEvaluationClass(returnObject, targetValues):
    opt = returnObject.opt
    #function value dynamic at target value
    #function evaluation counter at every target value
    fDynamic = []
    functionEval = []
    targetValueIndex = 0
    for fD in range(len(returnObject.fDynamic)):
        if(returnObject.fDynamic[fD] <= targetValues[targetValueIndex]):
            fDynamic.append(returnObject.fDynamic[fD])
            functionEval.append(fD)
            if(targetValueIndex < len(targetValues)-1):
                targetValueIndex = targetValueIndex + 1
            else:
                fDynamic.append(returnObject.fDynamic[-1])
                functionEval.append(len(returnObject.fDynamic))
                break
    
    if(len(targetValues) >= len(fDynamic)):
        fDynamic.append(returnObject.fDynamic[-1])
        functionEval.append(len(returnObject.fDynamic))

    obj = evaluationClass(opt, fDynamic, returnObject.varDynamic, functionEval, \
                          returnObject.crossoverRate, returnObject.scalarFactor, \
                          returnObject.averageF, returnObject.varFitness)
    return obj
        
        
        
class evaluationClass:
    def __init__(self, opt, fDynamic, varDynamic, functionEval, crossoverRate, \
                 scalarFactor, averageF, varFitness):
        self.opt = opt
        self.fDynamic = fDynamic
        self.varDynamic = varDynamic
        self.functionEval = functionEval
        self.crossoverRate = crossoverRate
        self.scalarFactor = scalarFactor
        self.averageF = averageF
        self.varFitness = varFitness



def saveReturnObject(obj, fileName):
    try:
        with open(fileName, "w") as f:
            json.dump(obj.__dict__, f)
    except TypeError:
        obj.opt = obj.opt.tolist()
        with open(fileName, "w") as f:
            json.dump(obj.__dict__, f)
         
            
def loadReturnObject(fileName):
    with open(fileName, "r") as f:
        objDict = json.load(f)
    obj = returnClass(objDict['errorMessage'], objDict['opt'], objDict['fopt'], \
                      objDict['functionEval'], objDict['fDynamic'], objDict['varDynamic'], \
                      objDict['generationCount'], objDict['scalarFactor'], objDict['crossoverRate'], \
                      objDict['varFitness'], objDict['population'], objDict['averageF'])
    return obj  


def saveEvaluationObject(retObj, fileName):
    try:
        with open(fileName, "w") as f:
            json.dump(retObj.__dict__, f)
    except TypeError:
        retObj.opt = retObj.opt.tolist()
        with open(fileName, "w") as f:
            json.dump(retObj.__dict__, f)
    
    return None


def loadEvaluationObject(fileName):
    with open(fileName, "r") as f:
        objDict = json.load(f)
    obj = evaluationClass(objDict['opt'], objDict['fDynamic'], \
                          objDict['varDynamic'], objDict['functionEval'], \
                          objDict['crossoverRate'], objDict['scalarFactor'], \
                          objDict['averageF'], objDict['varFitness'])
    return obj 




def crossoverEXP(xi, vi, CR):
    r, c = vi.shape
    L = 1
    while (np.random.rand() < CR and L < c):
        L = L + 1
    n = np.random.randint(0,c)            
    return np.hstack((xi[0][0:n], vi[0][n:n+L], xi[0][n+L:]))


def crossoverBIN(xi, vi, CR):
    r, c = vi.shape
    K = np.random.randint(low=0, high=c)
    ui = []
    for j in range(c):
        if j==K or np.random.rand() < CR:
            ui.append(vi[0][j])
        else:
            ui.append(xi[0][j])
    return np.asarray(ui)


def emptyCrossover(xi, vi, CR):
    return xi



def mutationRand1(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    indizes.remove(currentIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    r2 = np.array([population[indizes[2]]])      
    vi = r0 + F*(r1-r2)
    return vi

def mutationRand2(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    indizes.remove(currentIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    r2 = np.array([population[indizes[2]]])
    r3 = np.array([population[indizes[3]]])
    r4 = np.array([population[indizes[4]]])
    vi = r0 + F*(r1-r2) + F*(r3-r4)
    return vi

def mutationRand3(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    indizes.remove(currentIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    r2 = np.array([population[indizes[2]]])
    r3 = np.array([population[indizes[3]]])
    r4 = np.array([population[indizes[4]]])
    r5 = np.array([population[indizes[5]]])
    r6 = np.array([population[indizes[6]]])
    vi = r0 + F*(r1-r2) + F*(r3-r4) + F*(r5-r6)
    return vi

def mutationBest1(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    if(bestIndex == currentIndex):
        indizes.remove(currentIndex)
    else:
        indizes.remove(currentIndex)
        indizes.remove(bestIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    vi = population[bestIndex] + F*(r0 - r1)
    return vi

def mutationBest2(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    if(bestIndex == currentIndex):
        indizes.remove(currentIndex)
    else:
        indizes.remove(currentIndex)
        indizes.remove(bestIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    r2 = np.array([population[indizes[2]]])
    r3 = np.array([population[indizes[3]]])
    vi = population[bestIndex] + F*(r0 - r1) + F*(r2 - r3)
    return vi

def mutationCurrentToBest1(population, populationByIndex, currentIndex, bestIndex, F):
    indizes = populationByIndex[:]
    if(bestIndex == currentIndex):
        indizes.remove(currentIndex)
    else:
        indizes.remove(currentIndex)
        indizes.remove(bestIndex)
    indizes = np.random.permutation(indizes)
    r0 = np.array([population[indizes[0]]])
    r1 = np.array([population[indizes[1]]])
    vi = population[currentIndex] + F*(population[bestIndex] - population[currentIndex]) + F*(r0 - r1)
    return vi


def emptyMutation(population, populationByIndex, currentIndex, bestIndex, F):
    vi = population[currentIndex]
    return vi
    


def DE_x_y_z(population, crossoverOperator, mutationOperator, function, xshift, M, stoppingCond, F=0.5, CR=0.1, inner=False):
    
    if(inner):
        populationSize, dimension = population.shape
        populationByIndex = list(range(0, populationSize))
        functionValue = np.asarray([function(candidate, xshift, M) for candidate in population])
        functionEvalCounter = 0
        generationCounter = 0
        bestCandidateIndex = np.argmin(functionValue)
        fDynamics = []
        tempVar = np.var(population)
        varDynamics = []
        averagePopulationFunctionValue = []
        populationDynamics = []
        crossoverDynamic = []
        scalefactorDynamic = []
        varFitness = []
    else:
        populationSize, dimension = population.shape
        populationByIndex = list(range(0, populationSize))
        functionValue = np.asarray([function(candidate, xshift, M) for candidate in population])
        functionEvalCounter = populationSize
        generationCounter = 1
        bestCandidateIndex = np.argmin(functionValue)
        fDynamics = functionValue.tolist()
        tempVar = np.var(population)
        varDynamics = [tempVar]
        averagePopulationFunctionValue = [function(np.mean(population,0),xshift,M)]
        populationDynamics = [population.tolist()]
        crossoverDynamic = [CR]
        scalefactorDynamic = [F]
        varFitness = [np.var(functionValue)]

    try:
        while((functionEvalCounter < stoppingCond['maxEval'])           and \
              (generationCounter < stoppingCond['maxGen'])              and \
              (functionValue[bestCandidateIndex] > stoppingCond['minF']) and \
              (tempVar > stoppingCond['minVar'])):
            for i in range(populationSize):
                vi = mutationOperator(population, populationByIndex, i, bestCandidateIndex, F)
                ui = crossoverOperator(np.array([population[i]]), vi, CR)
                tempFuncValue = function(ui, xshift, M)
                functionEvalCounter = functionEvalCounter + 1
                fDynamics.append(tempFuncValue)
                tempVar = np.var(population)
                if(tempFuncValue < functionValue[i]):
                    population[i] = ui
                    functionValue[i] = tempFuncValue
            bestCandidateIndex=np.argmin(functionValue)
            varFitness.append(np.var(functionValue))
            generationCounter = generationCounter + 1
            populationDynamics.append(population.tolist())
            averagePopulationFunctionValue.append(np.mean(functionValue))
            crossoverDynamic.append(CR)
            scalefactorDynamic.append(F)
            varDynamics.append(np.var(population))
#            moved inside the for loop - catastrophical performance wise
#            fDynamics.append(functionValue[bestCandidateIndex])
        
        if not (functionValue[bestCandidateIndex] > stoppingCond['minF']):
            message = "success - minimum function value reached"
        elif not (varDynamics[-1] > stoppingCond['minVar']):
            message = "success - minimum population variance reached"
        elif not (functionEvalCounter < stoppingCond['maxEval']):
            message = "success - maximum function evaluation reached"
        elif not (generationCounter < stoppingCond['maxGen']):
            message = "success - maximum generation reached"
        else: 
            message = "error - minimization did not terminate"
            
        returnObject = returnClass(message, population[bestCandidateIndex].tolist(), functionValue[bestCandidateIndex], \
                                   functionEvalCounter, fDynamics, varDynamics, \
                                   generationCounter, scalefactorDynamic, crossoverDynamic, \
                                   varFitness, populationDynamics, averagePopulationFunctionValue)
        
    except Exception as e:
        A = np.zeros((1,dimension))
        returnObject = returnClass("error occured in file " + __file__ , A.fill(np.nan), np.nan, \
                                   functionEvalCounter, fDynamics, varDynamics, \
                                   generationCounter, scalefactorDynamic, crossoverDynamic, \
                                   varFitness, populationDynamics, averagePopulationFunctionValue)
        print('Error Message: ' + str(e))

    return returnObject





if __name__ == "__main__":
    import testFunktionen as fkt
    import pickle
    
    dim = 5
    popsize = 10*dim
    lowerConstraint = [(-1)*5 for i in range(dim)]
    upperConstraint = [5 for i in range(dim)]
    population = np.random.uniform(lowerConstraint, upperConstraint, size=(popsize,dim))
    stoppingCond = {"maxEval": 10000, "minF": 1e-8, "minVar": 1e-10, "maxGen": 10}
    result = DE_x_y_z(population, crossoverBIN, mutationCurrentToBest1, fkt.sphere, 0, np.identity(dim), stoppingCond, F=0.5, CR=0.2)
    
    assert (result.functionEval == popsize*result.generationCount), "generation - function evaluation do not agree"
    assert ("error" not in result.errorMessage), result.errorMessage
    
    saveReturnObject(result, "testSave.json")
    resultRetrieved = loadReturnObject("testSave.json")
    pickle.dump(result, open('returnObject.pickle', 'wb'))
    
    assert (result.errorMessage == resultRetrieved.errorMessage), "error message false"
    assert (result.fDynamic == resultRetrieved.fDynamic), "function value dynamic false"
    assert (result.varDynamic == resultRetrieved.varDynamic), "variance dynamic false"
    assert (result.opt == resultRetrieved.opt), "optimum position return object false"
    assert (result.fopt == resultRetrieved.fopt), "optimum function value false"
    assert (result.functionEval == resultRetrieved.functionEval), "function evaluation count false"
    assert (result.generationCount == resultRetrieved.generationCount), "generation count false"
    assert (result.scalarFactor == resultRetrieved.scalarFactor), "scalar factor false"
    assert (result.crossoverRate == resultRetrieved.crossoverRate), "crossover rate false"
    assert (result.population == resultRetrieved.population), "population false"
    assert (result.averageF == resultRetrieved.averageF), "average function value false"
    assert (result.varFitness == resultRetrieved.varFitness), "fitness variance value false"
    
    smallObject = convertReturnClassToEvaluationClass(result, [40, 30, 20, 10, 1, 1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8])
    saveEvaluationObject(smallObject, "testSmallObject.json")
    smallObjectRetrieved = loadEvaluationObject('testSmallObject.json')
    pickle.dump(smallObject, open('smallObject.pickle', 'wb'))
    
    assert(smallObject.averageF == smallObjectRetrieved.averageF), "average function value false"
    assert(smallObject.scalarFactor == smallObjectRetrieved.scalarFactor), "scalar factor false"
    assert(smallObject.crossoverRate == smallObjectRetrieved.crossoverRate), "crossover rate false"
    assert(smallObject.functionEval == smallObjectRetrieved.functionEval), "function evaluation count false"
    assert(smallObject.fDynamic == smallObjectRetrieved.fDynamic), "function value dynamic false"
    assert(smallObject.opt == smallObjectRetrieved.opt), "optimum position eval object false"
    assert (result.varFitness == resultRetrieved.varFitness), "fitness variance value false"
    assert (result.varDynamic == resultRetrieved.varDynamic), "variance dynamic false"
    
    print('all test passed')


