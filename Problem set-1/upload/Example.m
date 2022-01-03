clc; clear; close all;

x=[0 100];
y=[0 100];
z=[0 100];
L=10;
N=1000;

Fiber=Generate_Fiber(x,y,z,L,N);

Plot_Fiber(x,y,z,Fiber);