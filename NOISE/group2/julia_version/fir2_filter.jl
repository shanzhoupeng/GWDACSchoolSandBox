using DSP
using FFTW
## using PyCall
## @pyimport numpy

function interp1d(grid::AbstractVector{T}, xp::AbstractVector{S}, yp::AbstractVector{P}) where {T<:Real, S<:Real, P<:Real}
    if grid[1] < xp[1]
        error("cannot extrapolate to lower values than x")
    end
    if grid[end] > xp[end]
        error("cannot extrapolate to higher values than x")
    end
    n = length(grid)
    # initialize interpolated values
    yms = zeros(n)
    for i=1:n
        if in(grid[i], xp)
            yms[i] = yp[findall(grid[i].==xp)[1]]
        else
            idx1 = findall(grid[i].< xp)[1]
            idx2 = idx1-1#findall(grid[i].>xp)[1]
            yms[i] = yp[idx1] + (yp[idx2] - yp[idx1]) * ((grid[i] - xp[idx1])/(xp[idx2]-xp[idx1]))
        end     
    end
    return yms
end


    ## """
    ## FIR filter design using the window method.

    ## From the given frequencies `freq` and corresponding gains `gain`,
    ## this function constructs an FIR filter with linear phase and
    ## (approximately) the given frequency response.

    ## Parameters
    ## ----------
    ## numtaps : int
    ##     The number of taps in the FIR filter.  `numtaps` must be less than
    ##     `nfreqs`.
    ## freq : array_like, 1D
    ##     The frequency sampling points. Typically 0.0 to 1.0 with 1.0 being
    ##     Nyquist.  The Nyquist frequency can be redefined with the argument
    ##     `nyq`.
    ##     The values in `freq` must be nondecreasing.  A value can be repeated
    ##     once to implement a discontinuity.  The first value in `freq` must
    ##     be 0, and the last value must be `nyq`.
    ## gain : array_like
    ##     The filter gains at the frequency sampling points. Certain
    ##     constraints to gain values, depending on the filter type, are applied,
    ##     see Notes for details.
    ## nfreqs : int, optional
    ##     The size of the interpolation mesh used to construct the filter.
    ##     For most efficient behavior, this should be a power of 2 plus 1
    ##     (e.g, 129, 257, etc).  The default is one more than the smallest
    ##     power of 2 that is not less than `numtaps`.  `nfreqs` must be greater
    ##     than `numtaps`.
    ## window : string or (string, float) or float, or None, optional
    ##     Window function to use. Default is "hamming".  See
    ##     `scipy.signal.get_window` for the complete list of possible values.
    ##     If None, no window function is applied.
    ## nyq : float, optional
    ##     Nyquist frequency.  Each frequency in `freq` must be between 0 and
    ##     `nyq` (inclusive).
    ## antisymmetric : bool, optional
    ##     Whether resulting impulse response is symmetric/antisymmetric.
    ##     See Notes for more details.

    ## Returns
    ## -------
    ## taps : ndarray
    ##     The filter coefficients of the FIR filter, as a 1-D array of length
    ##     `numtaps`.

    ## See also
    ## --------
    ## scipy.signal.firwin

    ## Notes
    ## -----
    ## From the given set of frequencies and gains, the desired response is
    ## constructed in the frequency domain.  The inverse FFT is applied to the
    ## desired response to create the associated convolution kernel, and the
    ## first `numtaps` coefficients of this kernel, scaled by `window`, are
    ## returned.

    ## The FIR filter will have linear phase. The type of filter is determined by
    ## the value of 'numtaps` and `antisymmetric` flag.
    ## There are four possible combinations:

    ##    - odd  `numtaps`, `antisymmetric` is False, type I filter is produced
    ##    - even `numtaps`, `antisymmetric` is False, type II filter is produced
    ##    - odd  `numtaps`, `antisymmetric` is True, type III filter is produced
    ##    - even `numtaps`, `antisymmetric` is True, type IV filter is produced

    ## Magnitude response of all but type I filters are subjects to following
    ## constraints:

    ##    - type II  -- zero at the Nyquist frequency
    ##    - type III -- zero at zero and Nyquist frequencies
    ##    - type IV  -- zero at zero frequency

    ## .. versionadded:: 0.9.0

    ## References
    ## ----------
    ## .. [1] Oppenheim, A. V. and Schafer, R. W., "Discrete-Time Signal
    ##    Processing", Prentice-Hall, Englewood Cliffs, New Jersey (1989).
    ##    (See, for example, Section 7.4.)

    ## .. [2] Smith, Steven W., "The Scientist and Engineer's Guide to Digital
    ##    Signal Processing", Ch. 17. http://www.dspguide.com/ch17/1.htm

    ## Examples
    ## --------
    ## A lowpass FIR filter with a response that is 1 on [0.0, 0.5], and
    ## that decreases linearly on [0.5, 1.0] from 1 to 0:

    ## >>> from scipy import signal
    ## >>> taps = signal.firwin2(150, [0.0, 0.5, 1.0], [1.0, 1.0, 0.0])
    ## >>> print(taps[72:78])
    ## [-0.02286961 -0.06362756  0.57310236  0.57310236 -0.06362756 -0.02286961]

    ## """

function firwin2(numtaps::Int, freq::AbstractVector{T}, gain::AbstractVector{S}; 
        nfreqs::Int=-1, window::Function=hamming, nyq::Real=1.0, antisymmetric::Bool=false) where {T<:Real, S<:Real}


    if length(freq) != length(gain)
        error("freq and gain must be of same length.")
    end

    if (nfreqs > 1) && (numtaps >= nfreqs)
        error(string("ntaps must be less than nfreqs, but firwin2 was called with ntaps=", numtaps, " and nfreqs=", nfreqs))
    end


    if (freq[1] != 0) || (freq[end] != nyq)
        error("freq must start with 0 and end with `nyq`.")
    end
    d = diff(freq)
    if in(true, d .< 0)
        error("The values in freq must be nondecreasing.")
    end
    #d2 = d[:-1] + d[1:]
    d2 = freq[1:end-1] + freq[2:end]
    if in(true, d2 .== 0)
        error("A value in freq must not occur more than twice.")
    end

    if antisymmetric
        if numtaps % 2 == 0
            ftype = 4
        else
            ftype = 3
        end
    else
        if numtaps % 2 == 0
            ftype = 2
        else
            ftype = 1
        end
    end

    if (ftype == 2) && (gain[end] != 0.0)
        error("A Type II filter must have zero gain at the
                         Nyquist rate.")
    elseif (ftype == 3) && ((gain[1] != 0.0) || (gain[end] != 0.0))
        error("A Type III filter must have zero gain at zero 
                         and Nyquist rates.")
    elseif (ftype == 4) && (gain[1] != 0.0)
        error("A Type IV filter must have zero gain at zero rate.")
    end

    if nfreqs < 1
        nfreqs = 1 + 2^Int(ceil(log2(numtaps)))
    end

    # Tweak any repeated values in freq so that interp works.
    #eps = np.finfo(float).eps
    for k=1:length(freq)
        if (k < length(freq) - 1) && (freq[k] == freq[k + 1])
            freq[k] = freq[k] - eps()
            freq[k + 1] = freq[k + 1] + eps()
        end
    end

    # Linearly interpolate the desired response on a uniform mesh `x`.
    x = collect(range(0.0, nyq, length = nfreqs))
    fx = interp1d(x, freq, gain)
    #fx = numpy.interp(x, freq, gain)

    # Adjust the phases of the coefficients so that the first `ntaps` of the
    # inverse FFT are the desired filter coefficients.
    shift = exp.(-(numtaps - 1) / 2 * 1im * pi * x / nyq)
    if ftype > 2
        shift = shift.*1im
    end

    fx2 = fx .* shift
    
    # Use irfft to compute the inverse FFT.
    out_full = irfft(fx2, (size(fx2)[1]-1)*2)

    ## if window != nothing
    ##     # Create the window to apply to the filter coefficients.
    ##     from .signaltools import get_window
    ##     wind = get_window(window, numtaps, fftbins=False)
    ## else
    ##     wind = 1
    ## end
    wind = window(numtaps)

    # Keep only the first `numtaps` coefficients in `out`, and multiply by
    # the window.
    out = out_full[1:numtaps] .* wind

    if ftype == 3
        out[floor(Int, (size(out)[1] / 2))+1] = 0.0 #need to fin floor division operator in Julia
    end

return out
end
