% ���ø߾���Lobatto���ַ�����ʽ�� z = quadl(Fun,a,b)
clc;clear;
% ���λ��ַ�
% s = integral(inline('exp(-x.^2)'),-1,1)
fun='x^2';
F=int(sym( fun) ,'x')