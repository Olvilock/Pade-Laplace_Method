#pragma once

#include <pade_laplace.h>

#include <thrust/pair.h>
#include <thrust/complex.h>

namespace pl
{
    struct DeviceNode
    {
        double point;
        thrust::complex<double> value;

        DeviceNode() = default;
        __host__ __device__ DeviceNode(const pl::Node& node);
    };

    struct TrapeziaData
    {
        const DeviceNode* nodes;
        int count;
    };

    struct SplineData
    {
        struct SplineSegment
        {
            double pivot;
            thrust::complex<double> d;
        };
        struct SplineEndpoint
        {
            thrust::complex<double> a, b;
        };

        const SplineSegment* segments;
        int segments_count;

        const SplineEndpoint left;
        const SplineEndpoint right;
    };

    __device__ thrust::pair<thrust::complex<double>, thrust::complex<double>>
        transform(const thrust::complex<double> s, TrapeziaData data);

    __device__ thrust::pair<thrust::complex<double>, thrust::complex<double>>
        transform(const thrust::complex<double> s, SplineData data);
}