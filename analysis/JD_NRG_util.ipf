#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3				// Use modern global access method and strict wave access
#pragma DefaultTab={3,20,4}		// Set default tab width in Igor Pro 9 and later
#include <Global Fit 2>


/////////////////////////////////////////////////////////
///// 1 TIME RUN TO CREATE INTERPOLATED NRG DATASET /////
/////////////////////////////////////////////////////////

////////////////////
///// JOSH OLD /////
////////////////////
//macro nrgprocess()
//	// load in the nrg data.  Each 2D wave has energies (mu) on the x axis and gamma on the y axis,
//	// but the mus are different for different gammas.  We assume fixed T for this processing.
//	// The output is three different 2D waves, g_nrg, occ_nrg, and dndt_nrg, with ln(G/T) on the y axis and mu on the x-axis, assuming fixed Gamma
//	
////	MLLoadWave /M=2/Y=4/T/Z/S=2 "Macintosh HD:Users:luescher:Dropbox:work:Matlab:one_ck_analysis:meir data:NRGResultsNewWide.mat"
////	MLLoadWave /M=2/Y=4/T/Z/S=2/P=data "NRGResultsNewWide.mat"
////
////	Rename Conductance_mat,Conductance_wide; Rename DNDT_mat,DNDT_wide; Rename Gammas,Gammas_wide;
////	Rename Mu_mat,Mu_wide; Rename Occupation_mat,Occupation_wide
//////	MLLoadWave /M=2/Y=4/T/Z/S=2 "Macintosh HD:Users:luescher:Dropbox:work:Matlab:one_ck_analysis:meir data:NRGResultsNew.mat"
////MLLoadWave /M=2/Y=4/T/Z/S=2/P=data  "NRGResultsNew.mat"
//	
//	// Gammas become 1D waves listing the gammas for each row
//	matrixtranspose gammas; Redimension/N=-1 Gammas
//	matrixtranspose gammas_wide;Redimension/N=-1 Gammas_wide
//	
//	// Scale mu's by gamma's to make this appropriate for temperature dependence.
//	// The 2D resulting waves have the appropriate scaled mu at every x,y point.
//	duplicate mu_mat mu_n; duplicate mu_wide mu_n_wide // _n is short for "normalized", which signifies mu scaled by gamma
//	mu_n_wide /= gammas_wide[q]; mu_n /= gammas[q]
//	
//	// After this point working only with the _wide data
//	
//	// Set the first and last scaled mu's to be the max and min mu's so that the interpolation that is coming will not look outside the domain of existing data
//	variable maxval=wavemax(mu_n_wide), minval=wavemin(mu_n_wide)
//	mu_n_wide[0][]=maxval
//	mu_n_wide[(dimsize(mu_n_wide,0)-1)][]=minval
//	
//	// Make new waves to hold the NRG data, interpolated such that the x axis (the rescaled mu's) will be the same for each each row (each gamma)
//	make /n=(10000,30) dndt_n, cond_n, occ_n
//	
//	// Make a new 2D wave g_n_wide to contain the value of gamma/T at every point in the NRG waves.
//	// With this done, {mu_n_wide, g_n_wide, conductance_wide} are {X,Y,Z} points associated with
//	// the NRG data where X and Y are rescales mu's and gamma/T's.
//	// However, since the gammas provided to us by NRG are log spaced, it makes sense to 
//	duplicate mu_n_wide g_n_wide
//	g_n_wide = gammas_wide[q]
//	g_n_wide /= 1E-4 // Uses T=1E-4 from the NRG data
//	g_n_wide = ln(g_n_wide)
//	
//	// Load the nrg data, interpolated, into the waves made above.
//	interp_nrg()
//	imageinterpolate/dest=g_nrg/resl={100000,500} spline cond_n;copyscales cond_n g_nrg
//	imageinterpolate/dest=occ_nrg/resl={100000,500} spline occ_n;copyscales occ_n occ_nrg
//	imageinterpolate/dest=dndt_nrg/resl={100000,500} spline dndt_n;copyscales dndt_n dndt_nrg
//end
//
//
//function interp_nrg()
//	wave gammas=g_n_wide
//	wave dndt=dndt_n
//	wave cond=cond_n
//	wave occ=occ_n
//	wave mus=mu_n_wide
//	wave dndt_i=dndt_wide
//	wave cond_i=conductance_wide
//	wave occ_i=occupation_wide
//
//	
//	variable i, musmax, musmin, gammamax, gammamin
//	make /o/n=(dimsize(mus,0)) datx, daty
//	make /o/n=(dimsize(dndt,0)) interpwv
//	wavestats /q mus
//	musmax=v_max
//	musmin=v_min
//	wavestats /q gammas
//	gammamax=v_max
//	gammamin=v_min
//	SetScale/I x musmin,musmax,"", cond,dndt,occ;DelayUpdate
//	SetScale/I y gammamin,gammamax,"", cond,dndt,occ
//	SetScale/I x musmin,musmax,"", interpwv
//	for(i=0;i<dimsize(mus,1);i++)
//		datx[]=mus[p][i]
//		daty[]=dndt_i[p][i]
//		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
//		dndt[][i]=interpwv[p]
//		daty[]=cond_i[p][i]
//		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
//		wavestats /q interpwv
//		cond[][i]=interpwv[p]/v_max
//		daty[]=occ_i[p][i]
//		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
//		occ[][i]=interpwv[p]
//	endfor
//end

/////////////////////////////////////////////
/////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
macro kill_nrg_waves()
	killwaves /Z Conductance_mat
	killwaves /Z DNDT_mat
	killwaves /Z Mu_mat
	killwaves /Z Occupation_mat
	killwaves /Z gammas
	
	killwaves /Z Conductance_wide
	killwaves /Z DNDT_wide
	killwaves /Z Mu_wide
	killwaves /Z Occupation_wide
	killwaves /Z gammas_wide
	
	killwaves /Z Conductance_narrow
	killwaves /Z DNDT_narrow
	killwaves /Z Mu_narrow
	killwaves /Z Occupation_narrow
	killwaves /Z gammas_narrow
end



//////////////////////
///// JOHANN NEW /////
//////////////////////
function master_build_nrg_data()
	// load in the nrg data.  Each 2D wave has energies (mu) on the x axis and gamma on the y axis,
	// but the mus are different for different gammas.  We assume fixed T for this processing.
	// The output is three different 2D waves, g_nrg, occ_nrg, and dndt_nrg, with ln(G/T) on the y axis and mu on the x-axis, assuming fixed Gamma
	variable gamma_start_index = 1, gamma_end_index = 10
	wave Conductance_mat, DNDT_mat, Mu_mat, Occupation_mat
	duplicate /O/RMD=[][gamma_start_index, gamma_end_index] Conductance_mat Conductance_narrow
	duplicate /O/RMD=[][gamma_start_index, gamma_end_index] DNDT_mat DNDT_narrow
	duplicate /O/RMD=[][gamma_start_index, gamma_end_index] Mu_mat Mu_narrow 
	duplicate /O/RMD=[][gamma_start_index, gamma_end_index] Occupation_mat Occupation_narrow 

 	wave gammas, gammas_narrow
	duplicate /O/RMD=[][gamma_start_index, gamma_end_index] gammas gammas_narrow
	
	
	///////////////////////////////////////////////////
	///// INTERPOLATING THE ROUGHLY SPACED NARROW /////
	///////////////////////////////////////////////////
//	variable num_cols_narrow = dimsize(Conductance_narrow, 0)
//	variable num_rows_narrow = 100
//	imageinterpolate/dest=cond_narrow_fine /resl={num_cols_narrow, num_rows_narrow} spline Conductance_narrow; copyscales Conductance_narrow cond_narrow_fine
//	imageinterpolate/dest=dndt_narrow_fine /resl={num_cols_narrow, num_rows_narrow} spline DNDT_narrow; copyscales DNDT_narrow dndt_narrow_fine
//	imageinterpolate/dest=occ_narrow_fine /resl={num_cols_narrow, num_rows_narrow} spline Occupation_narrow; copyscales Occupation_narrow occ_narrow_fine
//	imageinterpolate/dest=mu_narrow_fine /resl={num_cols_narrow, num_rows_narrow} spline Mu_narrow; copyscales Mu_narrow mu_narrow_fine
//	
	
	////////////////////////////////////////////////
	///// REDIMENSION GAMMAS (TURN TO 1D WAVE) /////
	////////////////////////////////////////////////
	matrixtranspose gammas_narrow; Redimension/N=-1 gammas_narrow 

  	wave gammas_wide
	matrixtranspose gammas_wide; Redimension/N=-1 gammas_wide
	
	
	
	
	/////////////////////////////
	///// SCALE MU BY GAMMA /////
	/////////////////////////////
	wave mu_narrow, mu_wide
	duplicate /o mu_narrow mu_n_narrow;  
	mu_n_narrow /= gammas_narrow[q]
	
	duplicate /o mu_wide mu_n_wide 
	mu_n_wide /= gammas_wide[q];
	
	
	
	/////////////////////////////////
	///// MAX AND MIN MU VALUES /////
	/////////////////////////////////
	wave mu_n_wide, mu_n_narrow
	variable maxval, minval
	maxval= wavemax(mu_n_wide)
	minval = wavemin(mu_n_wide)
	
	if (wavemax(mu_n_narrow) > maxval)
		maxval = wavemax(mu_n_narrow)
	endif
	
	if (wavemin(mu_n_narrow) < minval)
		minval = wavemin(mu_n_narrow)
	endif
	
	
	////////////////
	///// WIDE /////
	////////////////
	// Set the first and last scaled mu's to be the max and min mu's so that the interpolation that is coming will not look outside the domain of existing data
	mu_n_wide[0][] = maxval
	mu_n_wide[(dimsize(mu_n_wide, 0) - 1)][] = minval
	
	// Make new waves to hold the NRG data, interpolated such that the x axis (the rescaled mu's) will be the same for each each row (each gamma)
	make /o/n=(10000, 30) dndt_n_wide, cond_n_wide, occ_n_wide
	
	// Make a new 2D wave g_n_wide to contain the value of gamma/T at every point in the NRG waves.
	// With this done, {mu_n_wide, g_n_wide, conductance_wide} are {X,Y,Z} points associated with
	// the NRG data where X and Y are rescales mu's and gamma/T's.
	// However, since the gammas provided to us by NRG are log spaced, it makes sense to 
	duplicate /o mu_n_wide g_n_wide
	wave gammas_wide
	g_n_wide = gammas_wide[q]
	g_n_wide /= 1E-4 // Uses T=1E-4 from the NRG data
	g_n_wide = ln(g_n_wide)
	
	interpolate_nrg_wide(maxval, minval)

	
	//////////////////
	///// NARROW /////
	//////////////////
	wave mu_n_narrow
	mu_n_narrow[0][] = maxval
	mu_n_narrow[(dimsize(mu_n_narrow, 0) - 1)][] = minval
	
	// Make new waves to hold the NRG data, interpolated such that the x axis (the rescaled mu's) will be the same for each each row (each gamma)
	make /o/n=(10000, gamma_end_index - gamma_start_index + 1) dndt_n_narrow, cond_n_narrow, occ_n_narrow
	
	// Make a new 2D wave g_n_wide to contain the value of gamma/T at every point in the NRG waves.
	// With this done, {mu_n_wide, g_n_wide, conductance_wide} are {X,Y,Z} points associated with
	// the NRG data where X and Y are rescales mu's and gamma/T's.
	// However, since the gammas provided to us by NRG are log spaced, it makes sense to 
	duplicate /o mu_n_narrow g_n_narrow
	wave gammas_narrow
	g_n_narrow = gammas_narrow[q]
	
	// we do this later
//	g_n_narrow /= 1E-4 // Uses T=1E-4 from the NRG data
//	g_n_narrow = ln(g_n_narrow)
//	
	interpolate_nrg_narrow(maxval, minval)
	
	
	
	/////////////////////////////
	///// IMAGE INTERPOLATE /////
	/////////////////////////////
//	// narrow and wide have a different number of points in the x-direction. So I should first interpolate the narrow data to have the same number
//	// of points in the x-direction. Then add the wide and narrow data together. Then do a fine image interpolate across the full wave.
	variable num_cols_wide = dimsize(cond_n_wide, 0)
	variable num_rows_wide = dimsize(cond_n_wide, 1)
	variable num_rows_narrow_fine = dimsize(cond_n_narrow, 1)
//	imageinterpolate/dest=cond_n_narrow_fine /resl={num_cols_wide, num_rows_narrow_fine} spline cond_n_narrow; copyscales cond_n_narrow cond_n_narrow_fine
//	imageinterpolate/dest=occ_n_narrow_fine /resl={num_cols_wide, num_rows_narrow_fine} spline occ_n_narrow; copyscales occ_n_narrow occ_n_narrow_fine
//	imageinterpolate/dest=dndt_n_narrow_fine /resl={num_cols_wide, num_rows_narrow_fine} spline dndt_n_narrow; copyscales dndt_n_narrow dndt_n_narrow_fine
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	///// INTERPOLATING NARROW TO BE LOG SPACED IN GAMMA AND PICK OUT NEW ROWS TO MATCH WIDE GAMMA SPACING/////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	wave gammas_wide_ln
	duplicate /o gammas_wide gammas_wide_ln
	gammas_wide_ln = ln(gammas_wide/1E-4)
	
	CurveFit/Q/M=2/W=0 line, gammas_wide_ln/D
	wave W_coef
	make /o/n=1 calc_gamma_narrow_wave

	variable min_gamma_narrow = wavemin(gammas_narrow), max_gamma_narrow = wavemax(gammas_narrow)
	variable i = -1
	variable calc_gamma = exp(W_coef[0]+W_coef[1]*i) * 1E-4
	
	do
		calc_gamma = exp(W_coef[0]+W_coef[1]*i) * 1E-4
		insertpoints /v = (ln(calc_gamma/1E-4)) 0, 1, calc_gamma_narrow_wave        // repeat
		i -= 1
	while (calc_gamma <= max_gamma_narrow && calc_gamma >= min_gamma_narrow)
	
	
	deletepoints dimsize(calc_gamma_narrow_wave, 0) - 1, 1, calc_gamma_narrow_wave
	deletepoints 0, 1, calc_gamma_narrow_wave

	wavestats /q calc_gamma_narrow_wave
	make /o/n=(10000, V_npnts) cond_narrow_interp, dndt_narrow_interp, occ_narrow_interp
	
	///// setting x - scale /////
	variable musmin = minval 
	variable musmax = maxval
	SetScale/I x musmin, musmax, "", cond_narrow_interp, dndt_narrow_interp, occ_narrow_interp
	
	///// setting y - scale /////
	variable gammamax, gammamin
	wavestats /q calc_gamma_narrow_wave
	gammamax = v_max
	gammamin = v_min
	SetScale/I y gammamin, gammamax, "", cond_narrow_interp, dndt_narrow_interp, occ_narrow_interp
	
	
	cond_narrow_interp = interp2d(cond_n_narrow, x, exp(y)*1E-4)
	occ_narrow_interp = interp2d(occ_n_narrow, x, exp(y)*1E-4)
	dndt_narrow_interp = interp2d(dndt_n_narrow, x, exp(y)*1E-4)
	
	num_rows_narrow_fine = dimsize(cond_narrow_interp, 1)
	
	 ///////////////////////////
	///// COMBINING DATA  /////
	///////////////////////////
	variable num_rows_combined = num_rows_narrow_fine + num_rows_wide
	
	make /o/n=(num_cols_wide, num_rows_combined) cond_n_combined, occ_n_combined, dndt_n_combined 
	SetScale/I x musmin, musmax, "", cond_n_combined, occ_n_combined, dndt_n_combined 
	
	gammamax = wavemax(gammas_wide_ln)
	gammamin = wavemin(calc_gamma_narrow_wave)
	SetScale/I y gammamin, gammamax, "", cond_n_combined, occ_n_combined, dndt_n_combined 
	

	for(i = 0; i < num_rows_narrow_fine; i++)
		cond_n_combined[][i] = cond_narrow_interp[p][i]
		occ_n_combined[][i] = occ_narrow_interp[p][i]
		dndt_n_combined[][i] = dndt_narrow_interp[p][i]
	endfor
	
	for(i = num_rows_narrow_fine; i < num_rows_combined; i++)
		cond_n_combined[][i] = cond_n_wide[p][i - num_rows_narrow_fine]
		occ_n_combined[][i] = occ_n_wide[p][i - num_rows_narrow_fine]
		dndt_n_combined[][i] = dndt_n_wide[p][i - num_rows_narrow_fine]
	endfor
	
	
	variable num_points_interp_x = 100000, num_points_interp_y = 500
//	make /o/n=(num_points_interp_x, num_points_interp_y) g_nrg, occ_nrg, dndt_nrg 
	
	imageinterpolate/dest=g_nrg /resl={num_points_interp_x, num_points_interp_y} spline cond_n_combined
	imageinterpolate/dest=occ_nrg /resl={num_points_interp_x, num_points_interp_y} spline occ_n_combined
	imageinterpolate/dest=dndt_nrg /resl={num_points_interp_x, num_points_interp_y} spline dndt_n_combined
	
	SetScale/I x musmin, musmax, "", g_nrg, occ_nrg, dndt_nrg 
	
	gammamax = wavemax(gammas_wide_ln)
	gammamin = wavemin(calc_gamma_narrow_wave)
	SetScale/I y gammamin, gammamax, "", g_nrg, occ_nrg, dndt_nrg 
	
	
	/////////////////////////////////
	///// KILL UNECESSARY WAVES /////
	/////////////////////////////////
	
	// occupation
	killwaves /Z Occupation_mat
	killwaves /Z Occupation_wide
	killwaves /Z Occupation_narrow
	killwaves /Z occ_narrow_fine
	killwaves /Z occ_n_wide
	killwaves /Z occ_n_narrow
	killwaves /Z occ_n_narrow_fine
	killwaves /Z occ_narrow_interp
	killwaves /Z occ_n_combined
	
	// dndt
	killwaves /Z DNDT_mat
	killwaves /Z DNDT_wide
	killwaves /Z DNDT_narrow
	killwaves /Z DNDT_narrow_fine
	killwaves /Z DNDT_n_wide
	killwaves /Z DNDT_n_narrow
	killwaves /Z DNDT_n_narrow_fine
	killwaves /Z dndt_narrow_interp
	killwaves /Z DNDT_n_combined  
	
	
	
	// conduction
	killwaves /Z Conductance_mat
	killwaves /Z Conductance_wide
	killwaves /Z Conductance_narrow
	killwaves /Z cond_narrow_fine
	killwaves /Z cond_n_wide
	killwaves /Z cond_n_narrow
	killwaves /Z cond_n_narrow_fine
	killwaves /Z cond_narrow_interp
	killwaves /Z cond_n_combined
	
	
	// mu
	killwaves /Z Mu_mat
	killwaves /Z Mu_wide
	killwaves /Z Mu_narrow
	killwaves /Z Mu_narrow_fine
	killwaves /Z Mu_n_wide
	killwaves /Z Mu_n_narrow
	killwaves /Z Mu_n_narrow_fine
	
	
	// gammas
	killwaves /Z gammas
	killwaves /Z gammas_wide
	killwaves /Z gammas_narrow
	killwaves /Z g_n_wide
	killwaves /Z g_n_narrow
//	killwaves /Z gammas_wide_ln
	killwaves /Z fit_gammas_wide_ln
//	killwaves /Z calc_gamma_narrow_wave
	
	
	// Temperature
	killwaves /Z Ts
	
	// leftovers
	killwaves /Z interpwv
	killwaves /Z datx
	killwaves /Z daty
end



function interpolate_nrg_narrow(variable musmax, variable musmin)
	wave gammas_narrow_interp = g_n_narrow
	wave mus_narrow_interp = mu_n_narrow
	
	wave dndt_narrow_interp = dndt_n_narrow
	wave cond_narrow_interp = cond_n_narrow
	wave occ_narrow_interp = occ_n_narrow
	
	wave dndt_narrow_raw = dndt_narrow
	wave cond_narrow_raw = conductance_narrow
	wave occ_narrow_raw = occupation_narrow
	
	variable gammamax, gammamin
	
	SetScale/I x musmin, musmax, "", cond_narrow_interp, dndt_narrow_interp, occ_narrow_interp
	
	wavestats /q gammas_narrow_interp
	gammamax = v_max
	gammamin = v_min
	SetScale/I y gammamin, gammamax, "", cond_narrow_interp, dndt_narrow_interp, occ_narrow_interp
	
	make /o/n=(dimsize(mus_narrow_interp, 0)) datx, daty
	make /o/n=(dimsize(dndt_narrow_interp, 0)) interpwv
	SetScale/I x musmin, musmax, "", interpwv
	
	variable i
	for(i=0;i<dimsize(mus_narrow_interp, 1); i++)
		datx[] = mus_narrow_interp[p][i]
		daty[] = dndt_narrow_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation // T=1: Linear || E=2: Match 2nd derivative || I=3:gives output at x-coords specified (destination must be created)|| Y=destination wave ||
		dndt_narrow_interp[][i] = interpwv[p]
		
		daty[] = cond_narrow_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
		wavestats /q interpwv
		cond_narrow_interp[][i] = interpwv[p]/v_max
		
		daty[] = occ_narrow_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
		occ_narrow_interp[][i] = interpwv[p]
	endfor
end



function interpolate_nrg_wide(variable musmax, variable musmin)
	wave gammas_wide_interp = g_n_wide
	wave mus_wide_interp = mu_n_wide
	
	wave dndt_wide_interp = dndt_n_wide
	wave cond_wide_interp = cond_n_wide
	wave occ_wide_interp = occ_n_wide
	
	wave dndt_wide_raw = dndt_wide
	wave cond_wide_raw = conductance_wide
	wave occ_wide_raw = occupation_wide

	
	variable gammamax, gammamin
	
	SetScale/I x musmin, musmax, "", cond_wide_interp, dndt_wide_interp, occ_wide_interp
	
	wavestats /q gammas_wide_interp
	gammamax = v_max
	gammamin = v_min
	SetScale/I y gammamin, gammamax, "", cond_wide_interp, dndt_wide_interp, occ_wide_interp
	
	make /o/n=(dimsize(mus_wide_interp, 0)) datx, daty
	make /o/n=(dimsize(dndt_wide_interp, 0)) interpwv
	SetScale/I x musmin, musmax, "", interpwv
	
	variable i
	for(i=0;i<dimsize(mus_wide_interp, 1); i++)
		datx[] = mus_wide_interp[p][i]
		daty[] = dndt_wide_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
		dndt_wide_interp[][i] = interpwv[p]
		
		daty[] = cond_wide_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
		wavestats /q interpwv
		cond_wide_interp[][i] = interpwv[p]/v_max
		
		daty[] = occ_wide_raw[p][i]
		Interpolate2/T=1/E=2/Y=interpwv/I=3 datx,daty //linear interpolation
		occ_wide_interp[][i] = interpwv[p]
	endfor
end



function build_GFinputs_struct(GFin, data, [gamma_over_temp_type, global_fit_conductance, use_previous_coef, linear_term, quadratic_term, crosscapacitive_term])
	STRUCT GFinputs &GFin
	STRUCT g_occdata &data
	string gamma_over_temp_type
	variable global_fit_conductance, use_previous_coef, linear_term, quadratic_term, crosscapacitive_term
	
	gamma_over_temp_type = selectString(paramisdefault(gamma_over_temp_type), gamma_over_temp_type, "high")
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // assuming repeats to average into 1 trace
	use_previous_coef = paramisdefault(use_previous_coef) ? 0 : use_previous_coef // assuming repeats to average into 1 trace	
	linear_term = paramisdefault(linear_term) ? 0 : linear_term // if linear_term not zero then let it go free. Default is to hold it at 0 
	quadratic_term = paramisdefault(quadratic_term) ? 0 : quadratic_term // if quadratic_term not zero then let it go free. Default is to hold it at 0 
	crosscapacitive_term = paramisdefault(crosscapacitive_term) ? 0 : crosscapacitive_term // if crosscapacitive_term not zero then let it go free. Default is to hold it at 0 
	
	variable counter = 0, numcoefs, i, j, numwvs = dimsize(data.temps, 0), numlinks, numunlinked, whichcoef
	wave data.temps
	
	
	////////////////////////////
	///// ADDING FIT FUNCS /////
	////////////////////////////
	make /t/o/n=1 fitfuncs
	wave /t GFin.fitfuncs
	if (global_fit_conductance == 1)
		GFin.fitfuncs[0] = "fitfunc_nrgcondAAO"
		// coef[0]: lnG/T for Tbase -- linked
		// coef[1]: x-scaling -- linked
		// coef[2]: x-offset
		// coef[3]: ln(T/Tbase) for different waves
		// coef[4]: peak height
		// coef[5]: const offset
		// coef[6]: linear
		numcoefs = 7
		make /o/n=(numcoefs) links
		links={1,1,0,0,0,0,0}
		numlinks = sum(links)
	else 
	// CHANGE
		GFin.fitfuncs[0] = "fitfunc_nrgctAA1"
		// coef[0]: lnG/T for Tbase -- linked
		// coef[1]: x-scaling -- linked
		// coef[2]: x-offset
		// coef[3]: ln(T/Tbase) for different waves
		// coef[4]: y-offset
		// coef[5]: linear
		// coef[6]: quadratic
		// coef[7]: amplitude
		// coef[8]: cubic
		// coef[9]: cross-capacitive
		
		numcoefs = 10
		make /o/n=(numcoefs) links
		links={1,1,0,0,0,0,0,0,0,0}
		numlinks = sum(links)
	endif
	

	
	
	/////////////////////////////
	///// ADDING DATA WAVES /////
	/////////////////////////////
	if (global_fit_conductance == 1) // add conductance data
		if (stringmatch(data.g_maskwvlist,""))
			make /t/o/n=(numwvs, 2) fitdata
		else
			make /t/o/n=(numwvs, 3) fitdata
			SetDimLabel 1, 2, Masks, fitdata
		endif
		wave /t GFin.fitdata
		for(i=0;i<numwvs;i++)
			GFin.fitdata[i][0] = stringfromlist(i, data.g_wvlist)
			GFin.fitdata[i][1] = "_calculated_"
			if (!stringmatch(data.g_maskwvlist, ""))
				GFin.fitdata[i][2] = stringfromlist(i, data.g_maskwvlist)
			endif
		endfor
	else // add charge transition data
		if (stringmatch(data.occ_maskwvlist,""))
			make /t/o/n=(numwvs, 2) fitdata
		else
			make /t/o/n=(numwvs, 3) fitdata
			SetDimLabel 1, 2, Masks, fitdata
		endif
		wave /t GFin.fitdata
		for(i=0;i<numwvs;i++)
			GFin.fitdata[i][0] = stringfromlist(i, data.occ_wvlist)
			GFin.fitdata[i][1] = "_calculated_"
			if (!stringmatch(data.occ_maskwvlist, ""))
				GFin.fitdata[i][2] = stringfromlist(i, data.occ_maskwvlist)
			endif
		endfor
	endif
	
	
	//////////////////////////////////////
	///// ADDING COEFFICIENT LINKING /////
	//////////////////////////////////////
	make /o/n=(numwvs,(numcoefs+4)) linking
	wave GFin.linking
	GFin.linking[][0] = 0 // column 0 is the index in fitfuncnames of the fit function to be used
	counter = 0
	for(i=0; i<numwvs; i++) // columns 1 and 2 are the start and end indices of each input wave when concatenated into one long wave
		GFin.linking[i][1] = counter
		counter += (dimsize($(fitdata[i]), 0) - 1)
		GFin.linking[i][2] = counter
		counter += 1
	endfor
	GFin.linking[][3] = numcoefs // column 3 is the number of fit coefs in the fit function for each wave
	// The GF will use a total number of fit coefficients numlinks+numunlinked:
	// The number of linked (global) coefs is numlinks
	// The number of other (unlinked) coefs is (numcoefs-numlinks)*numwvs
	// Preplinks is the wave that will correlate fit coefs for individual waves with the coef wave index for the global fit
	make /o/n=(numwvs, numcoefs) preplinks  
	preplinks = -1
	whichcoef = 0
	for(i=0; i<numcoefs; i++)
		if(links[i] == 1)
			preplinks[][i] = whichcoef
			whichcoef += 1
		endif
	endfor
//	preplinks[0][numcoefs - 1] = 0 // CHANGE link Tmeasure to Tbase for base T wave
	numunlinked = numwvs * (numcoefs - numlinks)
	for(i=0; i<numwvs; i++)
		for(j=0; j<numcoefs; j++)
			if(preplinks[i][j] == -1)
				preplinks[i][j] = whichcoef
				whichcoef += 1
			endif
		endfor
	endfor
	
	// columns 4 through numcoefs+3 in 'linking' are the values from prelinks
	GFin.linking[][4, (numcoefs + 3)] = preplinks[p][q-4]
		
		
	////////////////////////////////////////////////
	///// ADDING INITIAL GUESS OF COEFFICIENTS /////
	////////////////////////////////////////////////
//	use_previous_coef = 0
	if (use_previous_coef == 1)
		wave coefwave 
		wave GFin.coefwave
		
			// Set index 1 == 1 to hold the value  
		for(i=0; i<numwvs; i++)
			coefwave[3 + i*(numcoefs-numlinks)][1] = 1 // hold the lnTbase/T offsets

			if (global_fit_conductance == 1)
			
				if (linear_term == 0)
					coefwave[5 + i*(numcoefs-numlinks)][0] = 0 // constant offset
					coefwave[5 + i*(numcoefs-numlinks)][1] = 0 // constant offset
				endif
			
				if (linear_term != 0)
					coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // linear
					coefwave[6 + i*(numcoefs-numlinks)][1] = 0 // linear
				endif
			else
				if (linear_term != 0)
					coefwave[5 + i*(numcoefs-numlinks)][0] = -1e-4 // 1e-6 // linear
					coefwave[5 + i*(numcoefs-numlinks)][1] = 0 // 1e-6 // linear
				endif
				
				if (quadratic_term != 0)
					coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // quadtratic
					coefwave[6 + i*(numcoefs-numlinks)][1] = 0 // quadratic
				endif
				
				if (crosscapacitive_term != 0)
					coefwave[9 + i*(numcoefs-numlinks)][0] = 0 // quadtratic
					coefwave[9 + i*(numcoefs-numlinks)][1] = 0 // quadratic
				endif
				
			endif
		endfor
		
	else
		make /o/n=((whichcoef), 2) coefwave // since we are holding the extra base temp || REMOVE
		SetDimLabel 1, 1, Hold, coefwave
		wave GFin.coefwave
		coefwave = 0
		// For fitfunc_nrgcondAAO with N input waves these are:
		if (cmpstr(gamma_over_temp_type, "high") == 0)
			coefwave[0][0] = 3.9 // 3.3 // 3.0 // lnG/T for Tbase (linked)
			coefwave[1][0] = 0.02 //0.02 // 0.00373536 // 0.01 // 0.0045 // x scaling (linked)

		elseif (cmpstr(gamma_over_temp_type, "mid") == 0)
			coefwave[0][0] =  1.5 // 1.5 //0.1 //1 // lnG/T for Tbase (linked)
			coefwave[1][0] = 0.2 // 0.012// 0.005  //0.002 //0.16 // 0.02 // x scaling (linked)
			
		elseif (cmpstr(gamma_over_temp_type, "low") == 0)
			coefwave[0][0] = 1.3 // 1e-4 // lnG/Tbase (linked)
			coefwave[1][0] = 1e-1 //0.2 // 0.02 // x scaling (linked)
		endif
		
		// Set index 1 == 1 to hold the value  
		for(i=0; i<numwvs; i++)
			coefwave[3 + i*(numcoefs-numlinks)][0] = ln(data.temps[0]/data.temps[i]) // lnTbase/T offest for various T's
			coefwave[3 + i*(numcoefs-numlinks)][1] = 1 // hold the lnTbase/T offsets
			
			if (global_fit_conductance == 1)
				wave global_cond = $(GFin.fitdata[i][0])
				duplicate /o global_cond temp_smooth
				smooth 800, temp_smooth
				FindLevel /Q temp_smooth, wavemax(temp_smooth)
				
//				FindLevel /Q $(GFin.fitdata[i][0]), wavemax($(GFin.fitdata[i][0]))
				coefwave[2 + i*(numcoefs-numlinks)][0] = V_LevelX //+300 // x offset
				coefwave[4 + i*(numcoefs-numlinks)][0] = wavemax($(GFin.fitdata[i][0])) // peak height
				coefwave[5 + i*(numcoefs-numlinks)][0] = 0 // const offset
				coefwave[5 + i*(numcoefs-numlinks)][1] = 0 // const offset
				coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // linear
				coefwave[6 + i*(numcoefs-numlinks)][1] = 1 // linear
			else
				wave global_ct = $(GFin.fitdata[i][0])
				duplicate /o global_ct temp_smooth
				smooth 800, temp_smooth
				differentiate temp_smooth
				FindLevel /Q temp_smooth, wavemin(temp_smooth)
				coefwave[2 + i*(numcoefs-numlinks)][0] = V_LevelX
				coefwave[4 + i*(numcoefs-numlinks)][0] = mean($(GFin.fitdata[i][0])) // y offset
				coefwave[5 + i*(numcoefs-numlinks)][0] = 0 // linear
				coefwave[5 + i*(numcoefs-numlinks)][1] = 1 // linear
				coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // quadtratic
				coefwave[6 + i*(numcoefs-numlinks)][1] = 1 // quadratic
				coefwave[7 + i*(numcoefs-numlinks)][0] = -0.1//-(wavemax($(GFin.fitdata[i][0])) - wavemin($(GFin.fitdata[i][0])))/2 // amplitude
				coefwave[8 + i*(numcoefs-numlinks)][0] = 0 // cubic
				coefwave[8 + i*(numcoefs-numlinks)][1] = 1 // cubic
				coefwave[9 + i*(numcoefs-numlinks)][0] = 0 // cross-capacitive
				coefwave[9 + i*(numcoefs-numlinks)][1] = 1 // cross-capacitive
				
			endif
		endfor
	endif

//		
	//////////////////////////////
////	///// ADDING CONSTRAINTS /////
//////	//////////////////////////////
//	if (global_fit_conductance == 1)
//		make /t/o/n=2 constraintwave
////		wave /t GFin.constraintwave
////		GFin.constraintwave[0] = "K0<4"
////		GFin.constraintwave[1] = "K1>1e-12" // OLD JOSH LINE
////		GFin.constraintwave[1] = "K0>1" // OLD JOSH LINE
//	else
////		make /t/o/n=2 constraintwave
////		wave /t GFin.constraintwave
////		GFin.constraintwave[0] = "K0<4"
////		GFin.constraintwave[1] = "K1>0" // OLD JOSH LINE
////		GFin.constraintwave[1] = "K0>1" // OLD JOSH LINE
////		GFin.constraintwave[0] = "K0<30"
////		GFin.constraintwave[1] = "K0>10" // OLD JOSH LINE
//	endif
end



function build_g_occdata_struct(datnums, data)
	string datnums
	STRUCT g_occdata &data	
	string strnm, runlabel = "highG"
	string g_wvlist = "", g_maskwvlist = ""
	string occ_wvlist = "", occ_maskwvlist = ""
	
	variable num_dats = ItemsInList(datnums, ";")
	variable i
	string datnum
	for (i=0;i<num_dats;i+=1)
		datnum = stringfromlist(i, datnums)

		g_wvlist = g_wvlist + "dat" + datnum + "_dot_cleaned_avg;"
		occ_wvlist = occ_wvlist + "dat" + datnum + "_cs_cleaned_avg;"
		g_maskwvlist = g_maskwvlist + "dat" + datnum + "_dot_cleaned_avg_mask;"
		occ_maskwvlist = occ_maskwvlist + "dat" + datnum + "_cs_cleaned_avg_mask;"
		
	endfor
	 
	data.g_wvlist = g_wvlist
	strnm = runlabel + "g_wvlist"
	string /g $strnm=data.g_wvlist

	data.occ_wvlist = occ_wvlist
	strnm = runlabel + "occ_wvlist"
	string /g $strnm = data.occ_wvlist

	data.g_maskwvlist = g_maskwvlist
	strnm = runlabel + "g_maskwvlist"
	string /g $strnm = data.g_maskwvlist

	data.occ_maskwvlist = occ_maskwvlist
	strnm = runlabel + "occ_maskwvlist"
	string /g $strnm = data.occ_maskwvlist
end




function build_mask_waves(datnums, [global_fit_conductance])
	string datnums
	variable global_fit_conductance
	
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data

	
	string dot_wave_name, dot_mask_wave_name
	string cs_wave_name, cs_mask_wave_name
	
	variable num_dats = ItemsInList(datnums, ";")
	variable i
	string datnum
	
	for (i=0;i<num_dats;i+=1)
		datnum = stringfromlist(i, datnums)
		info_mask_waves(datnum, global_fit_conductance=global_fit_conductance)
	endfor

end




function info_mask_waves(datnum, [global_fit_conductance, base_wave_name])
	// create the masks for each individual datnum seperately
	string datnum
	variable global_fit_conductance
	string base_wave_name
	
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data
	base_wave_name = selectString(paramisdefault(base_wave_name), base_wave_name, "") // fit to datnums if fit_entropy_dats not specified

	//////////////////////////////////////////
	int auto_mask_wave = 1
	variable auto_percent_mask = 0.25
	/////////////////////////////////////////
	
	string dot_wave_name, dot_mask_wave_name
	string cs_wave_name, cs_mask_wave_name
	if (paramisdefault(base_wave_name) == 1)
		dot_wave_name = "dat" + datnum + "_dot_cleaned_avg"
		cs_wave_name = "dat" + datnum + "_cs_cleaned_avg"
	else
		dot_wave_name = "dat" + datnum + base_wave_name
		cs_wave_name = "dat" + datnum + base_wave_name
	endif
	
	dot_mask_wave_name = dot_wave_name + "_mask"
	cs_mask_wave_name = cs_wave_name + "_mask"
	
	variable dot_min_val = -inf, dot_max_val = inf, cs_min_val = -inf, cs_max_val = inf
	variable dot_min_index = -inf, dot_max_index = inf, cs_min_index = -inf, cs_max_index = inf
	variable datnum_declared = 1
	string mask_type = "linear"
	
///// SPRING EXPERIMENT 2023 /////
////////// high gamma low field ////////////////////////////////////////////////////
	if (cmpstr(datnum, "6386") == 0)
		dot_min_val = -1000; dot_max_val = 650
		cs_min_val = -1000; cs_max_val = 690
//		cs_min_val = -900; cs_max_val = 1000
	elseif (cmpstr(datnum, "6079") == 0)
		dot_min_val = -1000; dot_max_val = 650
		cs_min_val = -1000; cs_max_val = 1050
//		cs_min_val = -900; cs_max_val = 1000
	elseif (cmpstr(datnum, "6088") == 0)
		dot_min_val = -1000; dot_max_val = 650
		cs_min_val = -1500; cs_max_val = 1050
	elseif (cmpstr(datnum, "6085") == 0)
		dot_min_val = -1000; dot_max_val = 650
		cs_min_val = -1500; cs_max_val = 1050
	elseif (cmpstr(datnum, "6082") == 0)
		dot_min_val = -1000; dot_max_val = 650
		cs_min_val = -1500; cs_max_val = 1050
////////// mid gamma low field  ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "6080") == 0)
		dot_min_val = -1400; dot_max_val = 500
		cs_min_val = -1000; cs_max_val = 1430
//		cs_min_val = -600; cs_max_val = 1000
	elseif (cmpstr(datnum, "6089") == 0)
		dot_min_val = -1400; dot_max_val = 500
		cs_min_val = -1873; cs_max_val = 980
	elseif (cmpstr(datnum, "6086") == 0)
		dot_min_val = -1400; dot_max_val = 600
		cs_min_val = -2000; cs_max_val = 1286
	elseif (cmpstr(datnum, "6083") == 0)
		dot_min_val = -1400; dot_max_val = 600
		cs_min_val = -1667; cs_max_val = 967
////////// low gamma low field  ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "6081") == 0)
		dot_min_val = -300; dot_max_val = 200
//		cs_min_val = -2000; cs_max_val = 1000
		cs_min_val = -400; cs_max_val = 400
	elseif (cmpstr(datnum, "6090") == 0)
		dot_min_val = -400; dot_max_val = 200
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "6087") == 0)
		dot_min_val = -500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "6084") == 0)
		dot_min_val = -600; dot_max_val = 600
		cs_min_val = -2000; cs_max_val = 1000
////////// high gamma high field ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "6100") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -3000; cs_max_val = 1074
	elseif (cmpstr(datnum, "6097") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "6094") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "6091") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -3000; cs_max_val = 2000
////////// high gamma 2-3 transition ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "6225") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7000; cs_max_val = -1425//-1425
	elseif (cmpstr(datnum, "6234") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7000; cs_max_val = -1425//-1425
	elseif (cmpstr(datnum, "6231") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7000; cs_max_val = -1425//-1425
	elseif (cmpstr(datnum, "6228") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7000; cs_max_val = -1425// -1425
////////// mid gamma 2-3 transition ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "6226") == 0)
		dot_min_val = -6000; dot_max_val = -3000
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6235") == 0)
		dot_min_val = -6000; dot_max_val = -3000
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6232") == 0)
		dot_min_val = -6000; dot_max_val = -3000
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6229") == 0)
		dot_min_val = -6000; dot_max_val = -3000
		cs_min_val = -7900; cs_max_val = -1425
		
		
////////// AUTUMN experiment ////////////////////////////////////////////////////

	///// ENTROPY /////
	///// 50uV /////
	elseif (cmpstr(datnum, "1372") == 0)
		cs_min_val = -3488.3; cs_max_val = 3432.5
	///// 250uV /////
	elseif (cmpstr(datnum, "1373") == 0)
		cs_min_val = -2780; cs_max_val = 2783.3
	///// 500uV /////
	elseif (cmpstr(datnum, "1374") == 0)
		cs_min_val = -3275.7; cs_max_val = 2686.4
	///// 1000uV /////
	elseif (cmpstr(datnum, "1439") == 0)
		cs_min_val = -3275.7; cs_max_val = 2686.4
	///// symmetric /////
	elseif (cmpstr(datnum, "1473") == 0)
		cs_min_val = -3275.7; cs_max_val = 2686.4
	///// 2nd plateau /////
	elseif (cmpstr(datnum, "1505") == 0)
		cs_min_val = -3488.3; cs_max_val = 3432.5
	///// 2nd plateau /////
	elseif (cmpstr(datnum, "1537") == 0)
		cs_min_val = -3488.3; cs_max_val = 3432.5
		
	///// high gamma /////
	elseif (cmpstr(datnum, "1284") == 0)
		cs_min_val = -3000; cs_max_val = 3000
//		cs_min_val = -3000; cs_max_val = 2900
	elseif (cmpstr(datnum, "1288") == 0)
		cs_min_val = -3000; cs_max_val = 3000
	elseif (cmpstr(datnum, "1300") == 0)
		cs_min_val = -3000; cs_max_val = 3000
	elseif (cmpstr(datnum, "1296") == 0)
		cs_min_val = -3000; cs_max_val = 3000
	elseif (cmpstr(datnum, "1292") == 0)
		cs_min_val = -3000; cs_max_val = 3000
		
	///// mid-high gamma /////
	elseif (cmpstr(datnum, "1283") == 0)
		cs_min_val = -2000; cs_max_val = 1450
	elseif (cmpstr(datnum, "1287") == 0)
		cs_min_val = -2000;  cs_max_val = 1451
	elseif (cmpstr(datnum, "1299") == 0)
		cs_min_val = -2000; cs_max_val = 1451
	elseif (cmpstr(datnum, "1295") == 0)
		cs_min_val = -2000; cs_max_val = 1451
	elseif (cmpstr(datnum, "1291") == 0)
		cs_min_val = -2000; cs_max_val = 1451

		
	///// mid-low gamma /////
	elseif (cmpstr(datnum, "1282") == 0)
		cs_min_val = -1000; cs_max_val = 1000
	elseif (cmpstr(datnum, "1286") == 0)
		cs_min_val = -1000;  cs_max_val = 1000
	elseif (cmpstr(datnum, "1298") == 0)
		cs_min_val = -1000; cs_max_val = 1000
	elseif (cmpstr(datnum, "1294") == 0)
		cs_min_val = -1000; cs_max_val = 1000
	elseif (cmpstr(datnum, "1290") == 0)
		cs_min_val = -1000; cs_max_val = 1000
		
	///// low gamma /////
	elseif (cmpstr(datnum, "1281") == 0)
		cs_min_val = -700; cs_max_val = 300
	elseif (cmpstr(datnum, "1285") == 0)
		cs_min_val = -700; cs_max_val = 300
	elseif (cmpstr(datnum, "1297") == 0)
		cs_min_val = -700; cs_max_val = 500
	elseif (cmpstr(datnum, "1293") == 0)
		cs_min_val = -700; cs_max_val = 500
	elseif (cmpstr(datnum, "1289") == 0)
		cs_min_val = -700; cs_max_val = 500

		
	/////
	elseif (cmpstr(datnum, "1473") == 0)
		cs_max_val = 1496
		
//	///// CONDUCTANCE /////
//	////// high gamma /////
//	elseif (cmpstr(datnum, "699") == 0)
//		dot_min_val = -1000; dot_max_val = 1000
////		dot_min_val = -2000; dot_max_val = 1000
////		cs_min_val = -1000; cs_max_val = 1100
//		cs_min_val = -1500; cs_max_val = 1500
////		cs_min_val = -1700; cs_max_val = 1700
//	elseif (cmpstr(datnum, "695") == 0)
////		dot_min_val = -2000; dot_max_val = 1000
//		dot_min_val = -1000; dot_max_val = 1000
//		cs_min_val = -1500; cs_max_val = 1500
//	elseif (cmpstr(datnum, "691") == 0)
//		dot_min_val = -1000; dot_max_val = 1000
//		cs_min_val = -1500; cs_max_val = 1500
//////// mid-high gamma /////
//	elseif (cmpstr(datnum, "698") == 0)
//		dot_min_val = -900; dot_max_val = 400
//		cs_min_val = -800; cs_max_val = 900
////		cs_min_val = -550; cs_max_val = 800
//	elseif (cmpstr(datnum, "694") == 0)
//		dot_min_val = -900; dot_max_val = 400
//		cs_min_val = -1000; cs_max_val = 1000
//	elseif (cmpstr(datnum, "690") == 0)
//		dot_min_val = -900; dot_max_val = 400
//		cs_min_val = -1000; cs_max_val = 1500
//////// mid-weak gamma /////
//	elseif (cmpstr(datnum, "697") == 0)
//		dot_min_val = -550; dot_max_val = 250
////		cs_min_val = -1300; cs_max_val = 1000
//		cs_min_val = -350; cs_max_val = 400
//	elseif (cmpstr(datnum, "693") == 0)
//		dot_min_val = -550; dot_max_val = 300
//		cs_min_val = -750; cs_max_val = 750
//	elseif (cmpstr(datnum, "689") == 0)
//		dot_min_val = -550; dot_max_val = 300
//		cs_min_val = -1000; cs_max_val = 1000
//////// weak gamma /////
//	elseif (cmpstr(datnum, "696") == 0)
//		dot_min_val = -800; dot_max_val = 300
//		cs_min_val = -100; cs_max_val = 300
//	elseif (cmpstr(datnum, "692") == 0)
//		dot_min_val = -800; dot_max_val = 300
//		cs_min_val = -600; cs_max_val = 300
//	elseif (cmpstr(datnum, "688") == 0)
//		dot_min_val = -800; dot_max_val = 300
//		cs_min_val = -800; cs_max_val = 300

//////////////////////////////////////////////////////////////

///// SPRING EXPERIMENT 2024 /////
//	////// -640 high gamma /////
	elseif (cmpstr(datnum, "683") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1000; cs_max_val = 1100
	elseif (cmpstr(datnum, "701") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
	elseif (cmpstr(datnum, "695") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
	elseif (cmpstr(datnum, "689") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
//	////// -640 mid gamma /////
	elseif (cmpstr(datnum, "682") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1000; cs_max_val = 1100
	elseif (cmpstr(datnum, "700") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
	elseif (cmpstr(datnum, "694") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
	elseif (cmpstr(datnum, "688") == 0)
		dot_min_val = -1000; dot_max_val = 1000
		cs_min_val = -1500; cs_max_val = 1500
//	////// -640 low gamma /////
	elseif (cmpstr(datnum, "681") == 0)
		dot_min_val = -1000; dot_max_val = 800
		cs_min_val = -1000; cs_max_val = 1100
	elseif (cmpstr(datnum, "699") == 0)
		dot_min_val = -1000; dot_max_val = 800
		cs_min_val = -1100; cs_max_val = 1100
	elseif (cmpstr(datnum, "693") == 0)
		dot_min_val = -1000; dot_max_val = 800
		cs_min_val = -1100; cs_max_val = 1100
	elseif (cmpstr(datnum, "687") == 0)
		dot_min_val = -1000; dot_max_val = 800
		cs_min_val = -1100; cs_max_val = 1100
	
//	////// -840 high gamma /////
	elseif (cmpstr(datnum, "686") == 0)
		dot_min_val = -500; dot_max_val = 1300
		cs_min_val = -700; cs_max_val = 1500
	elseif (cmpstr(datnum, "704") == 0)
		dot_min_val = -500; dot_max_val = 1300
		cs_min_val = -700; cs_max_val = 1500
	elseif (cmpstr(datnum, "698") == 0)
		dot_min_val = -500; dot_max_val = 1300
		cs_min_val = -700; cs_max_val = 1500
	elseif (cmpstr(datnum, "692") == 0)
		dot_min_val = -500; dot_max_val = 1300
		cs_min_val = -700; cs_max_val = 1500
	elseif (cmpstr(datnum, "737") == 0) // 1uV
		dot_min_val = -1500; dot_max_val = 0
		cs_min_val = -1500; cs_max_val = 0
	elseif (cmpstr(datnum, "738") == 0) // 2uV
		dot_min_val = -1500; dot_max_val = 0
		cs_min_val = -1500; cs_max_val = 0
	elseif (cmpstr(datnum, "739") == 0) // 5uV
		dot_min_val = -1500; dot_max_val = 0
		cs_min_val = -1500; cs_max_val = 0
		
//	////// -840 mid gamma /////
	elseif (cmpstr(datnum, "685") == 0)
		dot_min_val = 500; dot_max_val = 1300
		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "703") == 0)
		dot_min_val = 500; dot_max_val = 1300
		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "697") == 0)
		dot_min_val = 500; dot_max_val = 1300
		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "691") == 0)
		dot_min_val = 500; dot_max_val = 1300
		cs_min_val = 500; cs_max_val = 1500
		
//	////// -840 weak gamma /////
	elseif (cmpstr(datnum, "684") == 0)
		 dot_max_val = 2000
//		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "702") == 0)
		dot_max_val = 2000
//		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "696") == 0)
		dot_max_val = 2000
//		cs_min_val = 500; cs_max_val = 1500
	elseif (cmpstr(datnum, "690") == 0)
		dot_max_val = 2000
//		cs_min_val = 500; cs_max_val = 1500

//	////// -1040 mid gamma /////
	elseif (cmpstr(datnum, "810") == 0)
		 dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = 0; cs_max_val = 2400
	elseif (cmpstr(datnum, "826") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -600; cs_max_val = 2400
	elseif (cmpstr(datnum, "822") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -600; cs_max_val = 2400
	elseif (cmpstr(datnum, "818") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -600; cs_max_val = 2400
	elseif (cmpstr(datnum, "814") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -600; cs_max_val = 2400


//	////// -1040 mid-stong gamma /////
	elseif (cmpstr(datnum, "811") == 0)
		 dot_min_val = -1000; dot_max_val = 2000
		cs_min_val = -1000; cs_max_val = 3000
	elseif (cmpstr(datnum, "827") == 0)
		dot_min_val = -1000; dot_max_val = 2000
		cs_min_val = -1000; cs_max_val = 3000
	elseif (cmpstr(datnum, "823") == 0)
		dot_min_val = -1000; dot_max_val = 2000
		cs_min_val = -1000; cs_max_val = 3000
	elseif (cmpstr(datnum, "819") == 0)
		dot_min_val = -1000; dot_max_val = 2000
		cs_min_val = -1000; cs_max_val = 3000
	elseif (cmpstr(datnum, "815") == 0)
		dot_min_val = -1000; dot_max_val = 2000
		cs_min_val = -1000; cs_max_val = 3000
		
//	////// -1040 stong gamma /////
	elseif (cmpstr(datnum, "812") == 0)
		 dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -1400; cs_max_val = 2200
	elseif (cmpstr(datnum, "828") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -1300; cs_max_val = 1700
	elseif (cmpstr(datnum, "824") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2500; cs_max_val = 2200
	elseif (cmpstr(datnum, "820") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2500; cs_max_val = 2200
	elseif (cmpstr(datnum, "816") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2500; cs_max_val = 2200

//	////// -1040 very-stong gamma /////
	elseif (cmpstr(datnum, "813") == 0)
		 dot_min_val = 2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 1600
	elseif (cmpstr(datnum, "829") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 3000
	elseif (cmpstr(datnum, "825") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 3000
	elseif (cmpstr(datnum, "821") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 3000
	elseif (cmpstr(datnum, "817") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 3000
		
//	////// asymmetric mid-weak gamma /////
	elseif (cmpstr(datnum, "1171") == 0)
		 dot_min_val = -1500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1300
	elseif (cmpstr(datnum, "1195") == 0)
		dot_min_val = -1500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1300
	elseif (cmpstr(datnum, "1189") == 0)
		dot_min_val = -1500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1300
	elseif (cmpstr(datnum, "1183") == 0)
		dot_min_val = -1500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1300
	elseif (cmpstr(datnum, "1177") == 0)
		dot_min_val = -1500; dot_max_val = 500
		cs_min_val = -2000; cs_max_val = 1300
		
//	////// asymmetric mid gamma /////
	elseif (cmpstr(datnum, "1173") == 0)
		 dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1197") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1191") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1185") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1179") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000

//	////// asymmetric mid-strong gamma /////
	elseif (cmpstr(datnum, "1175") == 0)
		 dot_min_val = 2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 360
	elseif (cmpstr(datnum, "1199") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 800
	elseif (cmpstr(datnum, "1193") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "1187") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1181") == 0)
		dot_min_val = -2000; dot_max_val = 2000
		cs_min_val = -2000; cs_max_val = 2000
		
//	////// setpoints symmetric mid-strong gamma /////
	elseif (cmpstr(datnum, "1239") == 0)
		cs_min_val = -1200; cs_max_val = 2000
	elseif (cmpstr(datnum, "1240") == 0)
		cs_min_val = -1200; cs_max_val = 2000
	elseif (cmpstr(datnum, "1241") == 0)
		cs_min_val = -1200; cs_max_val = 2000
	elseif (cmpstr(datnum, "1242") == 0)
		cs_min_val = -1200; cs_max_val = 2000
	elseif (cmpstr(datnum, "1243") == 0)
		cs_min_val = -1200; cs_max_val = 2000
	elseif (cmpstr(datnum, "1244") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1245") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1246") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1247") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1248") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1249") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1250") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1251") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1252") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1253") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1254") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1255") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1256") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1257") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1258") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1259") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1260") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1261") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1262") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1263") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1264") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1265") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1266") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1267") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1268") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1269") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1270") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1271") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1272") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1273") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1274") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1275") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1276") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1277") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1278") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1279") == 0)
		cs_min_val = -2000; cs_max_val = 2000
	
	elseif (cmpstr(datnum, "1333") == 0)
		cs_min_val = -2500; cs_max_val = 1076
	elseif (cmpstr(datnum, "1341") == 0)
		cs_min_val = -2500; cs_max_val = 2000
	elseif (cmpstr(datnum, "1349") == 0)
		cs_min_val = -2500; cs_max_val = 2000
	elseif (cmpstr(datnum, "1357") == 0)
		cs_min_val = -2500; cs_max_val = 2000
	elseif (cmpstr(datnum, "1365") == 0)
		cs_min_val = -2500; cs_max_val = 2000
	elseif (cmpstr(datnum, "1373") == 0)
		cs_min_val = -2500; cs_max_val = 2000
	elseif (cmpstr(datnum, "1381") == 0)
		cs_min_val = -2500; cs_max_val = 2000
		
//	////// setpoints asymmetric mid-strong gamma /////
	elseif (cmpstr(datnum, "1327") == 0)
		cs_min_val = -3000; cs_max_val = 622
	elseif (cmpstr(datnum, "1328") == 0)
		cs_min_val = -3000; cs_max_val = 1700
	elseif (cmpstr(datnum, "1329") == 0)
		cs_min_val = -3000; cs_max_val = 860
	elseif (cmpstr(datnum, "1330") == 0)
		cs_min_val = -3000; cs_max_val = 860
	elseif (cmpstr(datnum, "1331") == 0)
		cs_min_val = -3000; cs_max_val = 860
	elseif (cmpstr(datnum, "1335") == 0)
		cs_min_val = -3000; cs_max_val = 1700		
	elseif (cmpstr(datnum, "1336") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1337") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1338") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1339") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1343") == 0)
		cs_min_val = -3000; cs_max_val = 1930
	elseif (cmpstr(datnum, "1344") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1345") == 0)
		cs_min_val = -3000; cs_max_val = 2000		
	elseif (cmpstr(datnum, "1346") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1347") == 0)
		cs_min_val = -3000; cs_max_val = 2000			
	elseif (cmpstr(datnum, "1351") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1352") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1353") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1354") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1355") == 0)
		cs_min_val = -3000; cs_max_val = 2000			
	elseif (cmpstr(datnum, "1359") == 0)
		cs_min_val = -3000; cs_max_val = 1950	
	elseif (cmpstr(datnum, "1360") == 0)
		cs_min_val = -3000; cs_max_val = 1360
	elseif (cmpstr(datnum, "1361") == 0)
		cs_min_val = -3000; cs_max_val = 1657
	elseif (cmpstr(datnum, "1362") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1363") == 0)
		cs_min_val = -3000; cs_max_val = 2000			
	elseif (cmpstr(datnum, "1367") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1368") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1369") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1370") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1371") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1375") == 0)
		cs_min_val = -3000; cs_max_val = 2000		
	elseif (cmpstr(datnum, "1376") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1377") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1378") == 0)
		cs_min_val = -3000; cs_max_val = 2000	
	elseif (cmpstr(datnum, "1379") == 0)
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "1570") == 0)
		cs_min_val = -3000; cs_max_val = 2750
	elseif (cmpstr(datnum, "1512") == 0)
		cs_min_val = -3500; cs_max_val = 2750
	elseif (cmpstr(datnum, "1470") == 0)
		cs_min_val = -3500; cs_max_val = 2750
	elseif (cmpstr(datnum, "1749") == 0)
		cs_min_val = -4370; cs_max_val = 3400
	elseif (cmpstr(datnum, "1757") == 0)
		cs_min_val = -4370; cs_max_val = 1200
	elseif (cmpstr(datnum, "1757") == 0)
		cs_min_val = -4370; cs_max_val = 1200
	elseif (cmpstr(datnum, "2901") == 0)
		cs_min_val = -4640; cs_max_val = 3300
	elseif (cmpstr(datnum, "2946") == 0)
		cs_min_val = -4100; cs_max_val = 1618
	elseif (cmpstr(datnum, "2918") == 0)
		cs_min_val = -4360; cs_max_val = 2760
	elseif (cmpstr(datnum, "2906") == 0)
		cs_min_val = -2908; cs_max_val = 3120
	elseif (cmpstr(datnum, "2928") == 0)
		cs_min_val = -8000; cs_max_val = 8000
	elseif (cmpstr(datnum, "2943") == 0)
		cs_min_val = -8000; cs_max_val = 8000
	elseif (cmpstr(datnum, "2193") == 0)
		cs_min_val = -8000; cs_max_val = 4500
	elseif (cmpstr(datnum, "2958") == 0)
		cs_min_val = -8000; cs_max_val = 4500
	else
//		datnum_declared = 0
//		cs_min_val = -4990; cs_max_val = 2750
//		cs_min_val = -4370; cs_max_val = 5000; 	dot_min_val = -2000; dot_max_val = 1500 // symmetric
		
//		cs_min_val = -4000; cs_max_val = 3090; 	dot_min_val = -2000; dot_max_val = 1500 //asymmetric
//		cs_min_val = -3800; cs_max_val = 4800; 	dot_min_val = -2000; dot_max_val = 1500 //asymmetric

		cs_min_val = -1999; cs_max_val = 1999; 	dot_min_val = -2000; dot_max_val = 1500 //asymmetric

		
	endif
	
	datnum_declared = 1	

	
//	make /o/N=(dimsize($dot_wave_name, 0)) $dot_mask_wave_name = 1
//	make /o/N=(dimsize($cs_wave_name, 0)) $cs_mask_wave_name = 1
	if (global_fit_conductance == 1)
		duplicate /o $dot_wave_name $dot_mask_wave_name
		wave dot_mask_wave = $dot_mask_wave_name
		dot_mask_wave = 1
	endif
	
	duplicate /o $cs_wave_name $cs_mask_wave_name
	wave cs_mask_wave = $cs_mask_wave_name
	cs_mask_wave = 1
	
	if (datnum_declared == 1)

		if (global_fit_conductance == 1)
			///// CALCULATING MIN AND MAX INDEX /////
			dot_min_index = x2pnt($dot_wave_name, dot_min_val)
			if (dot_min_index < 0)
				dot_min_index = 0
			endif
			
			dot_max_index = x2pnt($dot_wave_name, dot_max_val)
			if (dot_max_index >= dimsize($dot_wave_name, 0))
				dot_max_index = dimsize($dot_wave_name, 0)
			endif
			
			if (auto_mask_wave == 1)
				wave global_cond = $dot_wave_name
				duplicate /o global_cond temp_smooth
				smooth 800, temp_smooth
				
				variable max_dot = wavemax(temp_smooth)
				variable min_dot = wavemin(temp_smooth)
				FindLevels/Q/D=risingEdges/EDGE=1 temp_smooth, (min_dot + (max_dot - min_dot)*auto_percent_mask);  
				FindLevels/Q/D=fallingEdges/EDGE=2 temp_smooth, (min_dot + (max_dot - min_dot)*auto_percent_mask)
				dot_min_index = x2pnt($dot_wave_name, risingEdges[0])
				dot_max_index = x2pnt($dot_wave_name, fallingEdges[inf])
			endif
			
			dot_mask_wave[0, dot_min_index] = 0
			dot_mask_wave[dot_max_index, dimsize($dot_wave_name, 0) - 1] = 0
			
		endif
		
		///// CALCULATING MIN AND MAX INDEX /////
		cs_min_index = x2pnt($cs_wave_name, cs_min_val)
		if (cs_min_index < 0)
			cs_min_index = 0
		endif
		
		cs_max_index = x2pnt($cs_wave_name, cs_max_val)
		if (cs_max_index >= dimsize($cs_wave_name, 0))
			cs_max_index = dimsize($cs_wave_name, 0)
		endif
		
		cs_mask_wave[0, cs_min_index] = 0
		cs_mask_wave[cs_max_index, dimsize($cs_wave_name, 0) - 1] = 0
		
	else
		print "Dat" + datnum + "no range info specified: mask = 1"
//		make /o/N=(dimsize($dot_wave_name, 0)) $dot_mask_wave_name = 1
//		make /o/N=(dimsize($cs_wave_name, 0)) $cs_mask_wave_name = 1
	endif
	
end



function [variable cond_chisq, variable occ_chisq, variable condocc_chisq] run_global_fit(string global_temps, 
																							string datnums, 
																							string gamma_over_temp_type, 
																							[
																							variable global_fit_conductance, 
																							variable fit_conductance, 
																							variable fit_entropy, 
																							string fit_entropy_dats, 
																							variable gamma_value, 
																							variable leverarm_value, 
																							variable load_previous_fit
																							])
	
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data
	fit_entropy = paramisdefault(fit_entropy) ? 0 : fit_entropy // default is to not fit to entropy
	fit_entropy_dats = selectString(paramisdefault(fit_entropy_dats), fit_entropy_dats, datnums) // fit to datnums if fit_entropy_dats not specified
	fit_conductance = paramisdefault(fit_conductance) ? 0 : fit_conductance
	gamma_value = paramisdefault(gamma_value) ? 0 : gamma_value
	leverarm_value = paramisdefault(leverarm_value) ? 0 : leverarm_value
	load_previous_fit = paramisdefault(load_previous_fit) ? 0 : load_previous_fit

	
	/////// build struct giving information on wave names /////
	STRUCT g_occdata data
	STRUCT GFinputs GFin
	build_g_occdata_struct(datnums, data)
	
	/////// build mask waves /////
	build_mask_waves(datnums, global_fit_conductance=global_fit_conductance)
	
	
	variable i, numcoefs, counter, numwvs, options, nrgline
	string strnm, wavenm, newwavenm, runlabel = gamma_over_temp_type + "G"

	/////// creating a temp wave from global_temps string /////
	int num_temps = ItemsInList(global_temps, ";")
	make /o/n=(num_temps) temps
	wave data.temps
	for (i=0; i<num_temps; i++)
		data.temps[i]=str2num(stringfromlist(i, global_temps))
	endfor
	
	strnm = runlabel + "temps"
	duplicate /o data.temps $strnm
	numwvs = dimsize(data.temps, 0)
	
	int num_entropy_dats = ItemsInList(fit_entropy_dats, ";")
	
	
	/////// checking length of conductance vs occupation /////
	if (global_fit_conductance == 1)
		if(itemsinlist(data.g_wvlist) != numwvs)
			print "Number of temps not consistent with number of waves"
			abort
		endif
	else
		if(itemsinlist(data.occ_wvlist) != numwvs)
			print "Number of temps not consistent with number of waves"
			abort
		endif
	endif
		
	/////// Define inputs for global fit to conductance data /////
	// (check out help in Global Fit 2 Help -- not Global Fit Help)
	build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=0)
	
	if (gamma_value != 0)
		GFin.coefwave[0][0] = gamma_value
	endif
	if (leverarm_value != 0)
		GFin.coefwave[1][0] = leverarm_value
	endif
	if (load_previous_fit == 1)
		wave GlobalFitCoefficients
		GFin.coefwave[][0] = GlobalFitCoefficients[p]
		
		if (global_fit_conductance == 1)
			GFin.coefwave[8][0] = ln(data.temps[0]/data.temps[1])
			GFin.coefwave[13][0] = ln(data.temps[0]/data.temps[2])
	//		GFin.coefwave[18][0] = ln(data.temps[0]/data.temps[3])
		else
			GFin.coefwave[11][0] = ln(data.temps[0]/data.temps[1])
			GFin.coefwave[19][0] = ln(data.temps[0]/data.temps[2])
	//		GFin.coefwave[27][0] = ln(data.temps[0]/data.temps[3])
			// allow linear to vary
			GFin.coefwave[5][1] = 0
			GFin.coefwave[13][1] = 0
			GFin.coefwave[21][1] = 0
			// allow occ-linear to vary
			GFin.coefwave[9][1] = 0
			GFin.coefwave[17][1] = 0
			GFin.coefwave[25][1] = 0
		endif
	endif
	
	
	options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
	DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)	
	
	// if fitting charge transitions :: let linear and then quadratic term go free.
	// set linear_term or quadratic_term to 0 to keep them at zero and hold them 
	int linear_term = 1, quadratic_term = 1, crosscapacitive_term = 1
	if ((global_fit_conductance == 0) && (load_previous_fit == 0))
		if (linear_term != 0)
			build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=linear_term, quadratic_term=0, crosscapacitive_term=0)
			options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
			DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
		endif
		
		if (crosscapacitive_term != 0)
			build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=0, quadratic_term=0, crosscapacitive_term=crosscapacitive_term)
			options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
			DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
		endif
		
//		if (quadratic_term != 0)
//			build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=0, quadratic_term=quadratic_term)
//			options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
//			DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
//		endif
		
	else
		///// FIRST ALLOW FOR CONSTANT OFFSET /////
//		build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=0)
//		options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
//		DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)

//		
//		///// SECOND ALLOW FOR LINEAR TERM /////
//		build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=1)
//		options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
//		DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
	endif
	
	ModifyGraph lsize=2,rgb(FitY)=(65535,16385,55749),rgb(FitY#1)=(65535,16385,55749),rgb(FitY#2)=(65535,16385,55749),rgb(FitY#3)=(65535,16385,55749),rgb(FitY#4)=(65535,16385,55749)

	print "Base T = ",(data.temps[0]),"mK :: Gamma/T = ", (exp(GFin.CoefWave[0][0]))
	
	variable total_cs_chisq
	variable /g GF_chisq
	if (global_fit_conductance == 1)
		cond_chisq = GF_chisq
	else
		total_cs_chisq = GF_chisq
	endif
	
//	///// hard coding 4 colours from blue to red
//	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
//	string colours = "0,0,65535;29524,1,58982;65535,65535,0;64981,37624,14500;65535,0,0"
	string colours = "0,0,65535;29524,1,58982;16385,49025,65535;65535,65535,0;65535,43690,0;65535,21845,0;65535,0,0"
	string colour
	variable red, green, blue
	//////////////////////////////////////////////////////////////////////
	///// Fitting and Plotting Charge Transition and Occupation Data /////
	//////////////////////////////////////////////////////////////////////
	// Use coefficients determined from conductance fit to fit charge transition data
	// Create occupation data
	string cond_data_name, cond_fit_name, cond_coef_name
	
	string cs_data_name, cs_fit_name, cs_coef_name
	string occ_data_name, occ_fit_name
	string entropy_base_name, entropy_coef_name, entropy_data_name, entropy_fit_name
	string entropy_nrg_data_name, entropy_nrg_coef_name, entropy_nrg_fit_name
	string cold_entropy_base_name, cold_entropy_coef_name, cold_entropy_data_name, cold_entropy_fit_name, cold_entropy_mask_name
	string occ_cold_entropy_data_name, occ_cold_entropy_fit_name
	string hot_entropy_base_name, hot_entropy_coef_name, hot_entropy_data_name, hot_entropy_fit_name
	string int_entropy_data_name, int_entropy_fit_name
	
	variable entropy_y_offset
	variable scaling_dt, scaling_amplitude, scaling_factor
	variable minx, maxx
	
	Display; KillWindow /Z global_fit; DoWindow/C/O global_fit
	Display; KillWindow /Z ct_fit; DoWindow/C/O ct_fit
	
	if (fit_entropy == 1)
		Display; KillWindow /Z global_fit_entropy; DoWindow/C/O global_fit_entropy
		Display; KillWindow /Z entropy_hot_cold; DoWindow/C/O entropy_hot_cold
		variable dndt_chisq
	endif
	
	for(i=0; i<numwvs; i++)
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		
		//////////////////////////////////////////
		///// Fitting Charge Transition data /////
		//////////////////////////////////////////
		if (global_fit_conductance == 1) // if fitting conductance, use conductance parameters to fit charge transitions
			cs_coef_name = "coef_" + stringfromlist(i,data.occ_wvlist)
			make/o /n=10 $cs_coef_name = 0 // Make coefficient wave for occupation fits
			wave cs_coef = $cs_coef_name
			
			wave curr_coef = $("coef_" + stringfromlist(i,data.g_wvlist))
			
			cs_data_name = stringfromlist(i,data.occ_wvlist)
			wave cs_data = $cs_data_name
			
			// fit cs data using gamma and theta from conductance fits
			cs_coef[0,3] = curr_coef[p]; wavestats /q cs_data; 
			cs_coef[4]=v_avg; cs_coef[5]=0; cs_coef[6]=0; cs_coef[7]=-abs((v_min-v_max)); cs_coef[8]=0; cs_coef[9]=0;  
			
			create_x_wave(cs_data)
			wave x_wave
			
			cs_fit_name = "fit_" + cs_data_name
			duplicate /o $cs_data_name $cs_fit_name

			
			///// with capacitance change
			FuncFit/Q/H="1101011011" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
			FuncFit/Q/H="1101001011" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
			FuncFit/Q/H="1111101110" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
			FuncFit/Q/H="1101001010" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D


//			///// without capacitance change
//			FuncFit/Q/H="1101011011" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
//			FuncFit/Q/H="1101001011" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
//			FuncFit/Q/H="1101000011" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
//			FuncFit/Q/H="1101000001" fitfunc_nrgctAA1 cs_coef cs_data   /M=$(stringfromlist(i,data.occ_maskwvlist)) /D
			total_cs_chisq += V_chisq // sum the chisq from each fit
		else 
			wave cs_coef = $("coef_" + stringfromlist(i,data.occ_wvlist))
			cs_data_name = stringfromlist(i,data.occ_wvlist)
			wave cs_data = $cs_data_name
			cs_fit_name = "Gfit_" + cs_data_name
		endif
		
		///// add occupation to graph /////
		appendtograph /W=ct_fit /r $cs_data_name
		ModifyGraph /W=ct_fit mode($cs_data_name)=2, lsize($cs_data_name)=2, rgb($cs_data_name)=(red,green,blue)
		appendtograph /W=ct_fit /r $cs_fit_name
		ModifyGraph /W=ct_fit mode($cs_fit_name)=0, lsize($cs_fit_name)=2, rgb($cs_fit_name)=(0,0,0)//(red,green,blue)
		
//		ModifyGraph offset($occ_data_name)={0,0.2*i}
//		ModifyGraph offset($occ_fit_name)={0,0.2*i}
			///// add charge transition ot the graph /////
			
		
		////////////////////////////////////
		///// Creating Occupation data /////
		////////////////////////////////////
		// charge transition coefficients are stored in cs_coef
		
		// creating occupation data and fit
		occ_data_name = cs_data_name + "_occ"
		occ_fit_name = cs_fit_name + "_occ"
		
		duplicate /o $cs_data_name $occ_data_name
		duplicate /o $cs_fit_name $occ_fit_name
		
		// calculating occupation data
		create_x_wave($occ_data_name)
		wave x_wave
		fitfunc_ct_to_occ(cs_coef, $occ_data_name, x_wave)
		
		// calculating occupation fit
		fitfunc_nrgocc(cs_coef, $occ_fit_name)	
			
		///// add occupation to graph /////
		appendtograph /W=global_fit /r $occ_data_name
		ModifyGraph /W=global_fit mode($occ_data_name)=2, lsize($occ_data_name)=2, rgb($occ_data_name)=(red,green,blue)
		appendtograph /W=global_fit /r $occ_fit_name
		ModifyGraph /W=global_fit mode($occ_fit_name)=0, lsize($occ_fit_name)=2, rgb($occ_fit_name)=(0,0,0)//(red,green,blue)
		
		variable occ_offset = 0.2
		ModifyGraph /W=global_fit offset($occ_data_name)={0,occ_offset*i}
		ModifyGraph /W=global_fit offset($occ_fit_name)={0,occ_offset*i}
		
		////////////////////////////////////////
		/////// Creating Conductance fit ///////
		////////////////////////////////////////
		cond_data_name = stringfromlist(i,data.g_wvlist)
		if ((fit_conductance == 1) || (global_fit_conductance == 1))
			if (global_fit_conductance == 0)
				cond_fit_name = "fit_" + cond_data_name
				cond_coef_name = "coef_" + cond_data_name
				
				make/o /n=7 $cond_coef_name = 0 
				wave cond_coef = $cond_coef_name
				cond_coef[0,4] = cs_coef[p]
				cond_coef[4] = 1
				cond_coef[5] = 0
				cond_coef[6] = 0
				
				duplicate /o $cond_data_name $cond_fit_name
				
				// coef[0]: lnG/T for Tbase -- linked
				// coef[1]: x-scaling -- linked
				// coef[2]: x-offset
				// coef[3]: ln(T/Tbase) for different waves
				// coef[4]: peak height
				// coef[5]: const offset
				// coef[6]: linear
				
//				FuncFit/Q/TBOX=768/H="1101011" fitfunc_nrgcondAAO cond_coef $cond_data_name /D=$cond_fit_name 
				FuncFit/Q/TBOX=768/H="1101001" fitfunc_nrgcondAAO cond_coef $cond_data_name /D /M=$(stringfromlist(i,data.g_maskwvlist))
				
				cond_chisq += V_chisq 

			else
				cond_fit_name = "Gfit_" + cond_data_name
			endif
			
//			// add conduction to graph
//			appendtograph /W=global_fit /l $cond_data_name
//			ModifyGraph /W=global_fit mode($cond_data_name)=2, lsize($cond_data_name)=2, rgb($cond_data_name)=(red,green,blue)
//			appendtograph /W=global_fit /l $cond_fit_name
//			ModifyGraph /W=global_fit mode($cond_fit_name)=0, lsize($cond_fit_name)=2, rgb($cond_fit_name)=(red,green,blue)
		endif
		
		
		////////////////////////////////////
		/////// Creating Entropy fit ///////
		////////////////////////////////////
		if ((fit_entropy == 1) && (i < num_entropy_dats)) 
			
			///////////////////////////////////////////////////////
			///// FIRST FIT TO COLD TRANSITIONS FROM ENTROPY /////
			///////////////////////////////////////////////////////
			cold_entropy_base_name = "dat" +  stringfromlist(i, fit_entropy_dats) + "_cs_cleaned_avg"
			cold_entropy_data_name = cold_entropy_base_name
			cold_entropy_coef_name = "coef_" + cold_entropy_base_name
			cold_entropy_fit_name = "fit_" + cold_entropy_base_name
			cold_entropy_mask_name = cold_entropy_base_name + "_mask"

			make/o /n=10 $cold_entropy_coef_name = 0 // Make coefficient wave for occupation fits
			wave cold_entropy_coef = $cold_entropy_coef_name
			cold_entropy_coef[0,9] = cs_coef[p]
			
			
			cold_entropy_coef[5] = 0
			cold_entropy_coef[6] = 0
			cold_entropy_coef[7] = -(wavemax($cold_entropy_data_name) - wavemin($cold_entropy_data_name))/2 // amplitude
			cold_entropy_coef[8] = 0
			cold_entropy_coef[9] = 0
			
			duplicate /o $cold_entropy_data_name $cold_entropy_fit_name
			
			if (waveexists($cold_entropy_mask_name) == 1)
				wave cold_entropy_mask_wave = $cold_entropy_mask_name 
			else
				duplicate /o $cold_entropy_data_name $cold_entropy_mask_name
				wave cold_entropy_mask_wave = $cold_entropy_mask_name
				cold_entropy_mask_wave = 1
			endif
			
			
//			FuncFit/Q/TBOX=768/H="1101011011" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name /M=cold_entropy_mask_wave
//			FuncFit/Q/TBOX=768/H="1101001011" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name /M=cold_entropy_mask_wave
//			FuncFit/Q/TBOX=768/H="1111101110" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name /M=cold_entropy_mask_wave
//			FuncFit/Q/TBOX=768/H="1101001010" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name /M=cold_entropy_mask_wave
			
			FuncFit/Q/TBOX=768/H="1101011011" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /M=cold_entropy_mask_wave /D
			FuncFit/Q/TBOX=768/H="1101001011" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /M=cold_entropy_mask_wave /D
			FuncFit/Q/TBOX=768/H="1111101110" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /M=cold_entropy_mask_wave /D
			FuncFit/Q/TBOX=768/H="1101001010" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /M=cold_entropy_mask_wave /D
			// letting G/T and leverarm go free
//			FuncFit/Q/TBOX=768/H="0001001010" fitfunc_nrgctAA1 cold_entropy_coef $cold_entropy_data_name /M=cold_entropy_mask_wave /D
			
			print "Cold transition G/T = " + num2str(exp(cold_entropy_coef[0]))
			
			AppendToGraph /W=global_fit_entropy /r $cold_entropy_data_name
			ModifyGraph /W=global_fit_entropy mode($cold_entropy_data_name)=2, lsize($cold_entropy_data_name)=1, rgb($cold_entropy_data_name)=(0,0,0)
			
			AppendToGraph /W=global_fit_entropy /r $cold_entropy_fit_name
			ModifyGraph /W=global_fit_entropy mode($cold_entropy_fit_name)=0, lsize($cold_entropy_fit_name)=2
			
			
			AppendToGraph /W=entropy_hot_cold $cold_entropy_data_name
			ModifyGraph /W=entropy_hot_cold mode($cold_entropy_data_name)=3, msize($cold_entropy_data_name)=2, mrkThick($cold_entropy_data_name)=1, rgb($cold_entropy_data_name)=(16385,28398,65535)
			
			
			AppendToGraph /W=entropy_hot_cold $cold_entropy_fit_name
			ModifyGraph /W=entropy_hot_cold mode($cold_entropy_fit_name)=0, lsize($cold_entropy_fit_name)=1, rgb($cold_entropy_fit_name)=(16385,28398,65535)
			
			
			//////////////////////////////////////////////////////
			///// SECOND FIT TO HOT TRANSITIONS FROM ENTROPY //////
			//////////////////////////////////////////////////////
			hot_entropy_base_name = "dat" +  stringfromlist(i, fit_entropy_dats) + "_cs_cleaned_hot_avg"
			hot_entropy_data_name = hot_entropy_base_name
			hot_entropy_coef_name = "coef_" + hot_entropy_base_name
			hot_entropy_fit_name = "fit_" + hot_entropy_base_name

			make/o /n=10 $hot_entropy_coef_name = 0 // Make coefficient wave for occupation fits
			wave hot_entropy_coef = $hot_entropy_coef_name
			hot_entropy_coef[0,9] = cold_entropy_coef[p]
			
			duplicate /o $hot_entropy_data_name $hot_entropy_fit_name
			
			// coef[0]: lnG/T for Tbase -- linked
			// coef[1]: x-scaling -- linked
			// coef[2]: x-offset
			// coef[3]: ln(T/Tbase) for different waves
			// coef[4]: const offset
			// coef[5]: linear
			// coef[6]: quadratic
			// coef[7]: amplitude
			// coef[8]: cubic
			// coef[9]: capacitance change
			
			// hold everything except x-scaling and x-offset
//			FuncFit/Q/H="1100111111" fitfunc_nrgctAA1 hot_entropy_coef $hot_entropy_data_name /M=cold_entropy_mask_wave /D
			hot_entropy_coef[3] = ln(1/1.3); FuncFit/Q/H="1101111111" fitfunc_nrgctAA1 hot_entropy_coef $hot_entropy_data_name /M=cold_entropy_mask_wave /D

			
			scaling_dt = (data.temps[0]/exp(hot_entropy_coef[3])) - (data.temps[0]/exp(cold_entropy_coef[3]))
			scaling_amplitude = hot_entropy_coef[7] + cold_entropy_coef[7]
			scaling_factor = abs(1 / scaling_amplitude / scaling_dt)
			print "dt = " + num2str(scaling_dt)
			print "percent T = " + num2str((data.temps[0]/exp(hot_entropy_coef[3]))/(data.temps[0]/exp(cold_entropy_coef[3])))
			print "Amplitude = " + num2str(scaling_amplitude)
			print "Scaling Factor = " + num2str(scaling_factor)
			
			
			AppendToGraph /W=entropy_hot_cold $hot_entropy_data_name
			ModifyGraph /W=entropy_hot_cold mode($hot_entropy_data_name)=3, msize($hot_entropy_data_name)=2, mrkThick($hot_entropy_data_name)=1//, rgb($hot_entropy_data_name)=(16385,28398,65535)
			
			
			AppendToGraph /W=entropy_hot_cold $hot_entropy_fit_name
			ModifyGraph /W=entropy_hot_cold mode($hot_entropy_fit_name)=0, lsize($hot_entropy_fit_name)=1//, rgb($hot_entropy_fit_name)=(0,0,0)
			
			////////////////////////////////////////////////////////
			///// THIRD TURN COLD TRANSITIONS INTO OCCUPATION //////
			////////////////////////////////////////////////////////
			occ_cold_entropy_data_name = cold_entropy_data_name + "_occ"
			occ_cold_entropy_fit_name = cold_entropy_fit_name + "_occ"
			
			duplicate /o $cold_entropy_data_name $occ_cold_entropy_data_name
			duplicate /o $cold_entropy_fit_name $occ_cold_entropy_fit_name
			
			// calculating occupation data
			create_x_wave($cold_entropy_data_name)
			wave x_wave
			fitfunc_ct_to_occ(cold_entropy_coef, $occ_cold_entropy_data_name, x_wave)
			
			// calculating occupation fit
			fitfunc_nrgocc(cold_entropy_coef, $occ_cold_entropy_fit_name)	
			
		
			
			////////////////////////////////////////////////////////////////////
			///// FOURTH FIT ENTROPY USING FIT PARAMS FROM COLD TRANSITION /////
			////////////////////////////////////////////////////////////////////
			entropy_base_name = "dat" +  stringfromlist(i, fit_entropy_dats) + "_numerical_entropy_avg"
			entropy_coef_name = "coef_" + entropy_base_name
			
			make/o /n=8 $entropy_coef_name = 0 // Make coefficient wave for occupation fits
			wave entropy_coef = $entropy_coef_name
			
			entropy_data_name = entropy_base_name
			entropy_fit_name = "fit_" + entropy_data_name
			wave entropy_data = $entropy_data_name
			// coef[0]: lnG/Tbase -- linked
			// coef[1]: x-scaling -- linked
			// coef[2]: x-offset
			// coef[3]: ln(Tbase/T) for different waves
			// coef[4]: const offset
			// coef[5]: linear
			// coef[6]: quadratic
			// coef[7]: amplitude
			
			AppendToGraph /W=global_fit_entropy $entropy_data_name
			ModifyGraph /W=global_fit_entropy mode($entropy_data_name)=2, lsize($entropy_data_name)=1, rgb($entropy_data_name)=(0,0,0)
						
			entropy_y_offset = mean($entropy_data_name, pnt2x($entropy_data_name, 0), pnt2x($entropy_data_name, dimsize(entropy_data, 0)/4))
			
//			entropy_data -= entropy_y_offset
			variable  entropy_y_mul = wavemax(entropy_data,  pnt2x(entropy_data, 9*dimsize(entropy_data, 0)/20), pnt2x(entropy_data, 19*dimsize(entropy_data, 0)/20))
//			entropy_data /= entropy_y_mul
			
			entropy_coef[0,3] = cold_entropy_coef[p]; entropy_coef[4]=0;  entropy_coef[5]=0; entropy_coef[6]=0; entropy_coef[7]=1;
			duplicate /o $cold_entropy_fit_name $entropy_fit_name
			wave entropy_fit = $entropy_fit_name
			
//			FuncFit/Q/H="11110110" fitfunc_nrgentropyAAO entropy_coef $entropy_data_name /D=entropy_fit  ///M=$(stringfromlist(i,data.occ_maskwvlist)) 
			FuncFit/Q/H="11110110" fitfunc_nrgentropyAAO entropy_coef $entropy_data_name /M=cold_entropy_mask_wave /D
			
			dndt_chisq += V_chisq
			
			AppendToGraph /W=global_fit_entropy $entropy_fit_name
			ModifyGraph /W=global_fit_entropy mode($entropy_fit_name)=0, lsize($entropy_fit_name)=2//,rgb($entropy_fit_name)=(0,0,0)
			
			
			/////////////////////////////////////////////////////////////////////////////
			///// FIFTH FITTING ENTROPY WITH NRG LETTING GAMMA AND LEVERARM GO FREE /////
			/////////////////////////////////////////////////////////////////////////////
			entropy_nrg_data_name = "nrg_" + entropy_base_name
			entropy_nrg_coef_name = "coef_" + entropy_nrg_data_name
			entropy_nrg_fit_name = "fit_" + entropy_nrg_data_name
			
			duplicate /o $entropy_data_name $entropy_nrg_data_name 
			
			duplicate /o entropy_coef $entropy_nrg_coef_name 
			wave entropy_nrg_coef = $entropy_nrg_coef_name
			
//			duplicate /o $cold_entropy_fit_name $entropy_nrg_fit_name
			duplicate /o $entropy_data_name $entropy_nrg_fit_name
			wave entropy_nrg_fit = $entropy_nrg_fit_name
			
			FuncFit/Q/H="00110110" fitfunc_nrgentropyAAO entropy_nrg_coef $entropy_nrg_data_name /M=cold_entropy_mask_wave /D ///D=entropy_nrg_fit
			
			AppendToGraph /W=global_fit_entropy $entropy_nrg_fit_name
			ModifyGraph /W=global_fit_entropy mode($entropy_nrg_fit_name)=0, lsize($entropy_nrg_fit_name)=2,rgb($entropy_nrg_fit_name)=(0,0,65535)
			
			
			/////////////////////////////////////////////
			///// SIXTH INTEGRATE ENTROPY AND SCALE /////
			/////////////////////////////////////////////
			
			int_entropy_data_name = entropy_data_name + "_int"
			int_entropy_fit_name = entropy_fit_name + "_int"
			
			duplicate /o $entropy_data_name $int_entropy_data_name
			duplicate /o $entropy_fit_name $int_entropy_fit_name
			
			Integrate  $entropy_data_name /D = $int_entropy_data_name
			Integrate  $entropy_fit_name /D = $int_entropy_fit_name
			
			wave int_entropy_data_wave = $int_entropy_data_name
			int_entropy_data_wave *= scaling_factor
			
			wave int_entropy_fit_wave = $int_entropy_fit_name
			int_entropy_fit_wave *= scaling_factor
			
			
			///// printing entropy fit outputs
			print "Fiting entropy, holding G/T from cold CT", entropy_coef
			print "Gamma/T = " + num2str(exp(entropy_coef[0]))
			print "Fiting entropy, letting G/T go free", entropy_nrg_coef
			print "Gamma/T = " + num2str(exp(entropy_nrg_coef[0]))
		endif
	endfor
	
//	print "Chisqr on occupation fit is " + num2str(total_cs_chisq/4)
	occ_chisq = total_cs_chisq/4 /// NOTE: Poorly named variable, this should be cs 
	if (global_fit_conductance == 0)
		cond_chisq /= 4
	endif
		
	return [cond_chisq, occ_chisq, dndt_chisq/4]
end






/////////////////////////////////
///// STRUCTURE DEFINITIONS /////
/////////////////////////////////
Structure g_occdata
	string g_wvlist
	string g_maskwvlist
	string occ_wvlist
	string occ_maskwvlist
	wave temps
Endstructure

Structure GFinputs
	wave /t fitfuncs
	wave /t fitdata
	wave linking
	wave coefwave
	wave /t constraintwave
Endstructure




	
////////////////////////////////////
///// FIT FUNCTION DEFINITIONS /////
////////////////////////////////////

/////////////////////////////////
///// conductance functions /////
/////////////////////////////////
Function fitfunc_RAWnrgcond(pw, yw) : FitFunc
	///// RAW NRG (no shift) ///// 
	Wave pw, yw
	wave nrg=g_nrg
	
	yw = pw[4] *  interp2d(nrg, x, (pw[0]+pw[3])) + pw[5]

End


Function fitfunc_nrgcondAAO(pw, yw, xw) : FitFunc // original negative
	WAVE pw, yw, xw
	wave nrg = g_nrg
	// coef[0]: lnG/Tbase for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: peak height
	// coef[5]: const offset
	// coef[6]: linear
	
	yw = pw[4] * interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[5] + pw[6]*xw
end


////////////////////////////////
///// occupation functions /////
////////////////////////////////
Function fitfunc_RAWnrgocc(pw, yw) : FitFunc
	///// RAW NRG (no shift) ///// 
	WAVE pw, yw
	wave nrg=occ_nrg
	
	yw = interp2d(nrg, x, (pw[0]+pw[3]))
end

Function fitfunc_nrgocc(pw, yw) : FitFunc
	// calculating NRG occupation fit to occupation data
	WAVE pw, yw
	wave nrg=occ_nrg
	
	yw = interp2d(nrg, (pw[1]*(x-pw[2])), (pw[0]+pw[3]))
end

Function fitfunc_ct_to_occ(pw, yw, xw) : FitFunc
	// calculating data occupation from charge transition
	WAVE pw, yw, xw
	
//	yw = pw[7]*interp2d(nrg, (pw[1]*(xw-pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2 + pw[8]*xw^3
// 	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2 + pw[8]*xw^3 + pw[9]*xw*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3]))
	
	// version 1 (assuming data is in shape of occupation)
//	yw[] = yw[p] - (pw[4] + pw[5]*xw[p] + pw[6]*xw[p]^2 + pw[8]*xw[p]^3)
//	yw[] = yw[p]/(pw[7] + pw[9]*xw[p])
	
	// version 2 (using NRG to subtract occupation linear term)
	wave nrg=occ_nrg
	yw[] = yw[p] - (pw[4] + pw[5]*xw[p] + pw[6]*xw[p]^2 + pw[8]*xw[p]^3 + pw[9]*xw*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])))
	yw[] = yw[p]/(pw[7])
end



////////////////////////////////
///// transition functions /////
////////////////////////////////
Function fitfunc_nrgctAAO(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	wave nrg = occ_nrg
	// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: const offset
	// coef[5]: linear
	// coef[6]: quadratic
	// coef[7]: amplitude
	// coef[8]: cubic
	
	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2 + pw[8]*xw^3
end

Function fitfunc_nrgctAA1(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	wave nrg = occ_nrg
	// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: const offset
	// coef[5]: linear
	// coef[6]: quadratic
	// coef[7]: amplitude
	// coef[8]: cubic
	// coef[9]: capacitance change
	
	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2 + pw[8]*xw^3 + pw[9]*xw*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3]))
end



/////////////////////////////
///// entropy functions /////
/////////////////////////////

Function fitfunc_rawnrgdndt(pw, yw) : FitFunc
	///// RAW NRG (no shift) ///// 
	WAVE pw, yw
	wave nrg=dndt_nrg
	
	yw = pw[7]*interp2d(nrg, x, (pw[0]+pw[3])) + pw[4]
end


Function fitfunc_nrgentropyAAO(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	wave nrg = dndt_nrg
	// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: const offset
	// coef[5]: linear
	// coef[6]: quadratic
	// coef[7]: amplitude
	
	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2
end