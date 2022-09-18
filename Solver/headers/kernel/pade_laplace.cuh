#pragma once

#include <device/transform.cuh>
#include <thrust/complex.h>

namespace pl
{
	struct DeviceTerm
	{
		thrust::complex<double> amp;
		thrust::complex<double> exp;
	};
	
	enum class Status {
		ok = 0b000,
		degenerate_system = 0b001,
		Aberth_divergence = 0b010,
		untouched = 0b100
	};
	__device__ const Status& operator |= (
		Status& me, const Status& other);

	struct batchedResult
	{
		DeviceTerm data;
		Status status;
	};

	__global__ void ker_pade_laplace(
		const thrust::complex<double>* grid,
		batchedResult* result_grid,
		TrapeziaData arg);
}