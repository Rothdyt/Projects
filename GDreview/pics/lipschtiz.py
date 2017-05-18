#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2017-05-15 16:10:14
# @Author  : Yutong,Dai (rothdyt@gmail.com)
# @Link    : rothdyt.github.io
# @Version : $Id$

import matplotlib.pyplot as plt
import numpy as np

class Lipschtiz():
	"A geometric interpretation of the Lipschtiz constant."
	def __init__(self, xseq, x0, L, l):
		"""
			xseq: np.arrage(x.start, x.end, step-size)
			x0  : the ponit which Taylor expassion is based on
			L: Lipschitiz constatnt
			l: strongly convex parameter
			f: user-defined f function outside of this class
			f_d1 : first-order deriviate of f
		"""
		self.x0 = x0
		self.xseq = xseq
		self.L = L
		self.l = l
		self.f_val_seq = f(xseq)
		self.f_upper_seq = f(x0) + f_d1(x0) * (xseq - x0) + L / 2 * (xseq - x0) ** 2
		self.f_lower_seq = f(x0) + f_d1(x0) * (xseq - x0) - L / 2 * (xseq - x0) ** 2
		self.f_strong_seq = f(x0) + f_d1(x0) * (xseq - x0) + l / 2 * (xseq - x0) ** 2
		self.tangent_seq = f(x0) + f_d1(x0) * (xseq - x0)

	def geomlipschtiz(self): 
		plt.plot(self.xseq, self.f_val_seq, label = "$f(x)$")
		plt.plot(self.xseq, self.f_upper_seq, label = "$\phi_1(x) = f(x_0) + (x-x_0)^Tf'(x_0) + L/2||x-x_0||^2$")
		plt.plot(self.xseq, self.f_lower_seq, label = "$\phi_2(x) = f(x_0) + (x-x_0)^Tf'(x_0) - L/2||x-x_0||^2$")
		plt.xlim(-3.5,3.5)
		plt.ylim(-5,5)
		plt.xlabel('x')
		plt.ylabel('y')
		plt.title('$L = $' + str(self.L))
		plt.annotate("$x_0$",ha="center",va="bottom",
			xytext=(self.x0 + 1, f(self.x0) + 1), xy=(self.x0,f(self.x0)),
			arrowprops = { 'arrowstyle' : "->", 'facecolor' : 'black'})
		plt.legend(loc = "best")
		plt.show()

	def geomstrongconvex(self):
		plt.plot(self.xseq, self.f_val_seq, label = "$f(x)$")
		plt.plot(self.xseq, self.f_upper_seq, label = "$\phi_1(x) = f(x_0) + (x-x_0)^Tf'(x_0) + L/2||x-x_0||^2$")
		plt.plot(self.xseq, self.f_strong_seq, label = "$\phi_2(x) = f(x_0) + (x-x_0)^Tf'(x_0) + \ell/2||x-x_0||^2$")
		plt.plot(self.xseq, self.tangent_seq, label = "$l(x) = f(x_0) + (x-x_0)^Tf'(x_0) $")
		plt.xlim(-3.5,3.5)
		plt.ylim(-5,5)
		plt.xlabel('x')
		plt.ylabel('y')
		plt.title('$L = $' + str(self.L) + "," + '$\ell = $' + str(self.l))
		plt.annotate("$x_0$",ha="center",va="bottom",
			xytext=(self.x0 + 1, f(self.x0) + 1), xy=(self.x0,f(self.x0)),
			arrowprops = { 'arrowstyle' : "->", 'facecolor' : 'black'})
		plt.legend(loc = "best")
		plt.show()
############################################################
def f(x):
	return x ** 2
def f_d1(x):
	return 2 * x
xseq = np.arange(-3,3,0.01)
example = Lipschtiz(xseq=xseq, x0=-1, L=3, l=1)
example.geomlipschtiz()
example.geomstrongconvex()