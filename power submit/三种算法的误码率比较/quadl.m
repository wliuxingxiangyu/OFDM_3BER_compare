% 采用高精度Lobatto积分法，格式： z = quadl(Fun,a,b)
clc;clear;
% 梯形积分法
% s = integral(inline('exp(-x.^2)'),-1,1)
fun='x^2';
F=int(sym( fun) ,'x')