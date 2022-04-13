#pragma once

#include <thrust/complex.h>

namespace pl
{
	__device__ double slae_LU(const int dim, thrust::complex<double> *glb_buf);
}