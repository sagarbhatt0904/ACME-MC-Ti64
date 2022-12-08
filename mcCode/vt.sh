#!/bin/bash

for i in {0000..1000..100}; do
	./mmsp2vti TiGradient.$i.dat TiGradient.$i.vti
done
