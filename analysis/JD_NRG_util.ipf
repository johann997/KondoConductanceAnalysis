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
//	g_n_narrow /= 1E-4 // Uses T=1E-4 from the NRG data
//	g_n_narrow = ln(g_n_narrow)
	
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
	gammas_wide_ln = ln(gammas_wide_ln/1E-4)
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
	killwaves /Z gammas_wide_ln
	killwaves /Z fit_gammas_wide_ln
	killwaves /Z calc_gamma_narrow_wave
	
	
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



function build_GFinputs_struct(GFin, data, [gamma_over_temp_type, global_fit_conductance, use_previous_coef, linear_term, quadratic_term])
	STRUCT GFinputs &GFin
	STRUCT g_occdata &data
	string gamma_over_temp_type
	variable global_fit_conductance, use_previous_coef, linear_term, quadratic_term
	
	gamma_over_temp_type = selectString(paramisdefault(gamma_over_temp_type), gamma_over_temp_type, "high")
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // assuming repeats to average into 1 trace
	use_previous_coef = paramisdefault(use_previous_coef) ? 0 : use_previous_coef // assuming repeats to average into 1 trace	
	linear_term = paramisdefault(linear_term) ? 0 : linear_term // if linear_term not zero then let it go free. Default is to hold it at 0 
	quadratic_term = paramisdefault(quadratic_term) ? 0 : quadratic_term // if quadratic_term not zero then let it go free. Default is to hold it at 0 
	
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
		numcoefs = 5
		make /o/n=(numcoefs) links
		links={1,1,0,0,0}
		numlinks = sum(links)
	else 
	// CHANGE
		GFin.fitfuncs[0] = "fitfunc_nrgctAAO"
		// coef[0]: lnG/T for Tbase -- linked
		// coef[1]: x-scaling -- linked
		// coef[2]: x-offset
		// coef[3]: ln(T/Tbase) for different waves
		// coef[4]: y-offset
		// coef[5]: linear
		// coef[6]: quadratic
		// coef[7]: amplitude
		numcoefs = 8
		make /o/n=(numcoefs) links
		links={1,1,0,0,0,0,0,0}
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
//				coefwave[4 + i*(numcoefs-numlinks)][0] = wavemax($(GFin.fitdata[i][0])) // peak height
			else
				if (linear_term != 0)
					coefwave[5 + i*(numcoefs-numlinks)][0] = 0 // 1e-6 // linear
					coefwave[5 + i*(numcoefs-numlinks)][1] = 0 // 1e-6 // linear
				endif
				
				if (quadratic_term != 0)
					coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // quadtratic
					coefwave[6 + i*(numcoefs-numlinks)][1] = 1 // quadratic
				endif
////				coefwave[7 + i*(numcoefs-numlinks)][0] = -(wavemax($(GFin.fitdata[i][0])) - wavemin($(GFin.fitdata[i][0])))/2 // amplitude
				
			endif
		endfor
		
	else
		make /o/n=((whichcoef), 2) coefwave // since we are holding the extra base temp || REMOVE
		SetDimLabel 1, 1, Hold, coefwave
		wave GFin.coefwave
		coefwave = 0
		// For fitfunc_nrgcondAAO with N input waves these are:
		if (cmpstr(gamma_over_temp_type, "high") == 0)
			coefwave[0][0] = 3.85 // lnG/T for Tbase (linked)
			coefwave[1][0] = 0.004 //0.00019 // 0.01 // x scaling (linked)

		elseif (cmpstr(gamma_over_temp_type, "mid") == 0)
			coefwave[0][0] = 1 // lnG/T for Tbase (linked)
			coefwave[1][0] = 0.012 //0.002 //0.16 // 0.02 // x scaling (linked)
			
		elseif (cmpstr(gamma_over_temp_type, "low") == 0)
			coefwave[0][0] = 1e-4 // lnG/Tbase (linked)
			coefwave[1][0] = 0.3 //0.13 // 0.02 // x scaling (linked)
		endif
		
		// Set index 1 == 1 to hold the value  
		for(i=0; i<numwvs; i++)
			coefwave[2 + i*(numcoefs-numlinks)][0] = 0 // x offset
			coefwave[3 + i*(numcoefs-numlinks)][0] = ln(data.temps[0]/data.temps[i]) // lnTbase/T offest for various T's
			coefwave[3 + i*(numcoefs-numlinks)][1] = 1 // hold the lnTbase/T offsets
			
			if (global_fit_conductance == 1)
				coefwave[4 + i*(numcoefs-numlinks)][0] = wavemax($(GFin.fitdata[i][0])) // peak height
			else
				coefwave[4 + i*(numcoefs-numlinks)][0] = mean($(GFin.fitdata[i][0])) // y offset
				coefwave[5 + i*(numcoefs-numlinks)][0] = 0 // 1e-6 // linear
				coefwave[5 + i*(numcoefs-numlinks)][1] = 1 // 1e-6 // linear
				coefwave[6 + i*(numcoefs-numlinks)][0] = 0 // quadtratic
				coefwave[6 + i*(numcoefs-numlinks)][1] = 1 // quadratic
				coefwave[7 + i*(numcoefs-numlinks)][0] = -(wavemax($(GFin.fitdata[i][0])) - wavemin($(GFin.fitdata[i][0])))/1 // amplitude
				
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
	
	
////////// high gamma low field ////////////////////////////////////////////////////
//	if (cmpstr(datnum, "6079") == 0)
//		dot_min_val = -2000; dot_max_val = 1000
//		cs_min_val = -3000; cs_max_val = 1074
//	elseif (cmpstr(datnum, "6088") == 0)
//		dot_min_val = -2000; dot_max_val = 1000
//		cs_min_val = -3000; cs_max_val = 2000
//	elseif (cmpstr(datnum, "6085") == 0)
//		dot_min_val = -2000; dot_max_val = 1000
//		cs_min_val = -3000; cs_max_val = 2000
//	elseif (cmpstr(datnum, "6082") == 0)
//		dot_min_val = -2000; dot_max_val = 1000
//		cs_min_val = -3000; cs_max_val = 2000
	if (cmpstr(datnum, "6079") == 0)
		dot_min_val = -2500; dot_max_val = 2500
		cs_min_val = -3000; cs_max_val = 1074
	elseif (cmpstr(datnum, "6088") == 0)
		dot_min_val = -2500; dot_max_val = 2500
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "6085") == 0)
		dot_min_val = -2500; dot_max_val = 2500
		cs_min_val = -3000; cs_max_val = 2000
	elseif (cmpstr(datnum, "6082") == 0)
		dot_min_val = -2500; dot_max_val = 2500
		cs_min_val = -3000; cs_max_val = 2000
////////// mid gamma low field  ////////////////////////////////////////////////////
//	elseif (cmpstr(datnum, "6080") == 0)
//		dot_min_val = -500; dot_max_val = 500
//		cs_min_val = -1315; cs_max_val = 936
//	elseif (cmpstr(datnum, "6089") == 0)
//		dot_min_val = -500; dot_max_val = 500
//		cs_min_val = -1873; cs_max_val = 980
//	elseif (cmpstr(datnum, "6086") == 0)
//		dot_min_val = -500; dot_max_val = 500
//		cs_min_val = -3000; cs_max_val = 1286
//	elseif (cmpstr(datnum, "6083") == 0)
//		dot_min_val = -500; dot_max_val = 500
//		cs_min_val = -1667; cs_max_val = 967
	elseif (cmpstr(datnum, "6080") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -1000; cs_max_val = 1430
	elseif (cmpstr(datnum, "6089") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -1873; cs_max_val = 980
	elseif (cmpstr(datnum, "6086") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -3000; cs_max_val = 1286
	elseif (cmpstr(datnum, "6083") == 0)
		dot_min_val = -2000; dot_max_val = 1000
		cs_min_val = -1667; cs_max_val = 967
////////// low gamma low field  ////////////////////////////////////////////////////
//	elseif (cmpstr(datnum, "6081") == 0)
//		dot_min_val = -500; dot_max_val = 200
//		cs_min_val = -2000; cs_max_val = 1000
//	elseif (cmpstr(datnum, "6090") == 0)
//		dot_min_val = -500; dot_max_val = 200
//		cs_min_val = -2000; cs_max_val = 1000
//	elseif (cmpstr(datnum, "6087") == 0)
//		dot_min_val = -750; dot_max_val = 200
//		cs_min_val = -2000; cs_max_val = 500
//	elseif (cmpstr(datnum, "6084") == 0)
//		dot_min_val = -750; dot_max_val = 300
//		cs_min_val = -2000; cs_max_val = 500
	elseif (cmpstr(datnum, "6081") == 0)
		dot_min_val = -800; dot_max_val = 800
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "6090") == 0)
		dot_min_val = -800; dot_max_val = 800
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "6087") == 0)
		dot_min_val = -800; dot_max_val = 800
		cs_min_val = -2000; cs_max_val = 1000
	elseif (cmpstr(datnum, "6084") == 0)
		dot_min_val = -800; dot_max_val = 800
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
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6234") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6231") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7900; cs_max_val = -1425
	elseif (cmpstr(datnum, "6228") == 0)
		dot_min_val = -6000; dot_max_val = -3200
		cs_min_val = -7900; cs_max_val = -1425
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
////////// autumn experiment ////////////////////////////////////////////////////
	elseif (cmpstr(datnum, "1287") == 0)
		cs_max_val = 1230
	elseif (cmpstr(datnum, "1283") == 0)
		cs_max_val = 6.33*200
	elseif (cmpstr(datnum, "1284") == 0)
		cs_max_val = 13*200
	elseif (cmpstr(datnum, "1285") == 0)
		cs_max_val = 370
	elseif (cmpstr(datnum, "1288") == 0)
		cs_max_val = 2873
	elseif (cmpstr(datnum, "1300") == 0)
		cs_max_val = 2917
	elseif (cmpstr(datnum, "1473") == 0)
		cs_max_val = 1496
//////////////////////////////////////////////////////////////
	else
		datnum_declared = 0
	endif
	
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



function [variable cond_chisq, variable occ_chisq, variable condocc_chisq] run_global_fit(string global_temps, string datnums, string gamma_over_temp_type, [variable global_fit_conductance, variable fit_conductance, variable fit_entropy, string fit_entropy_dats])
		
	global_fit_conductance = paramisdefault(global_fit_conductance) ? 1 : global_fit_conductance // default is to fit to conductance data
	fit_entropy = paramisdefault(fit_entropy) ? 0 : fit_entropy // default is to not fit to entropy
	fit_entropy_dats = selectString(paramisdefault(fit_entropy_dats), fit_entropy_dats, datnums) // fit to datnums if fit_entropy_dats not specified
	fit_conductance = paramisdefault(fit_conductance) ? 0 : fit_conductance

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
	options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
	DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)	
	
	// if fitting charge transitions :: let linear and then quadratic term go free.
	// set linear_term or quadratic_term to 0 to keep them at zero and hold them 
	int linear_term = 1, quadratic_term = 1
	if (global_fit_conductance == 0)
		if (linear_term != 0)
			build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=linear_term, quadratic_term=0)
			options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
			DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
		endif
		
		if (quadratic_term != 0)
			build_GFinputs_struct(GFin, data, gamma_over_temp_type = gamma_over_temp_type, global_fit_conductance=global_fit_conductance, use_previous_coef=1, linear_term=0, quadratic_term=quadratic_term)
			options = NewGFOptionFIT_GRAPH + NewGFOptionMAKE_FIT_WAVES + NewGFOptionQUIET + NewGFOptionGLOBALFITVARS
			DoNewGlobalFit(GFin.fitfuncs, GFin.fitdata, GFin.linking, GFin.CoefWave, $"", GFin.ConstraintWave, options, 2000, 1)
		endif
	endif
	
	ModifyGraph lsize=2,rgb(FitY)=(65535,16385,55749),rgb(FitY#1)=(65535,16385,55749),rgb(FitY#2)=(65535,16385,55749),rgb(FitY#3)=(65535,16385,55749)

//	print "Base T = ",(GFin.CoefWave[0][0]),"mK :: Gamma/T = ", (GFin.CoefWave[3][0])/(GFin.CoefWave[0][0])
	print "Base T = ",(data.temps[0]),"mK :: Gamma/T = ", (exp(GFin.CoefWave[0][0]))

	variable /g GF_chisq
//	print "Chisqr on conductance fit is",GF_chisq
	cond_chisq = GF_chisq
	
	
	///// hard coding 4 colours from blue to red
	string colours = "0,0,65535;29524,1,58982;64981,37624,14500;65535,0,0"
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
	string cold_entropy_base_name, cold_entropy_coef_name, cold_entropy_data_name, cold_entropy_fit_name, cold_entropy_mask_name
	string occ_cold_entropy_data_name, occ_cold_entropy_fit_name
	string hot_entropy_base_name, hot_entropy_coef_name, hot_entropy_data_name, hot_entropy_fit_name
	string int_entropy_data_name, int_entropy_fit_name
	
	variable total_cs_chisq, entropy_y_offset
	variable scaling_dt, scaling_amplitude, scaling_factor
	display
	for(i=0; i<numwvs; i++)
		
		///// getting correct colour for plot /////
		colour = stringfromlist(i, colours, ";")
		red = str2num(stringfromlist(0, colour, ","))
		green = str2num(stringfromlist(1, colour, ","))
		blue = str2num(stringfromlist(2, colour, ","))
		
		if (global_fit_conductance == 1) // if fitting conductance, use conductance parameters to fit charge transitions
			cs_coef_name = "coef_" + stringfromlist(i,data.occ_wvlist)
			make/o /n=8 $cs_coef_name = 0 // Make coefficient wave for occupation fits
			wave curr_coef = $("coef_" + stringfromlist(i,data.g_wvlist))
			wave cs_coef = $cs_coef_name
			
			cs_data_name = stringfromlist(i,data.occ_wvlist)
			wave cs_data = $cs_data_name
			
			// fit cs data using gamma and theta from conductance fits
			cs_coef[0,3] = curr_coef[p]; wavestats /q cs_data; cs_coef[4]=v_avg; cs_coef[5]=0; cs_coef[6]=0; cs_coef[7]=-abs((v_min-v_max));  
			create_x_wave(cs_data)
			wave x_wave
			
			cs_fit_name = "fit_" + cs_data_name
			duplicate /o $cs_data_name $cs_fit_name
			
			FuncFit/Q/H="11010110"/X=1 fitfunc_nrgctAAO cs_coef cs_data  /M=$(stringfromlist(i,data.occ_maskwvlist)) /D=$cs_fit_name
			FuncFit/Q/H="11010010"/X=1 fitfunc_nrgctAAO cs_coef cs_data  /M=$(stringfromlist(i,data.occ_maskwvlist)) /D=$cs_fit_name
//			FuncFit/Q/H="11010000"/X=1 fitfunc_nrgctAAO cs_coef cs_data  /M=$(stringfromlist(i,data.occ_maskwvlist)) /D

		else 
			wave cs_coef = $("coef_" + stringfromlist(i,data.occ_wvlist))
			cs_data_name = stringfromlist(i,data.occ_wvlist)
			wave cs_data = $cs_data_name
			cs_fit_name = "Gfit_" + cs_data_name
		endif
			///// add charge transition ot the graph /////
//		appendtograph /r cs_data
//		ModifyGraph mode($cs_data_name)=2, lsize($cs_data_name)=2, rgb($cs_data_name)=(red,green,blue)
//		appendtograph /r $cs_fit_name
//		ModifyGraph mode($cs_fit_name)=0, lsize($cs_fit_name)=2, rgb($cs_fit_name)=(red,green,blue)
	
		total_cs_chisq += V_chisq // sum the chisq from each fit
			
		
		////////////////////////////////////
		///// Creating Occupation data /////
		////////////////////////////////////
		// charge transition coefficients are stored in cs_coef
		wave occ_coef
		duplicate /o cs_coef occ_coef
		// need to force linear, quadratic terms to zero 
		occ_coef[4]=0; occ_coef[5]=0; occ_coef[6]=0; occ_coef[7]=1;
		
		// creating occupation data and fit
		occ_data_name = cs_data_name + "_occ"
		occ_fit_name = cs_fit_name + "_occ"
		
		duplicate /o $cs_data_name $occ_data_name
		duplicate /o $cs_fit_name $occ_fit_name
		
		// calculating occupation data
		create_x_wave($occ_data_name)
		wave x_wave
//		fitfunc_nrgctAAO(occ_coef, $occ_data_name, x_wave)
		fitfunc_ct_to_occ(cs_coef, $occ_data_name, x_wave)
		
		// calculating occupation fit
		create_x_wave($occ_fit_name)
		wave x_wave
//		fitfunc_nrgctAAO(occ_coef, $occ_fit_name, x_wave)
		fitfunc_nrgocc(cs_coef, $occ_fit_name)	
			
		///// add occupation to graph /////
		appendtograph /r $occ_data_name
		ModifyGraph mode($occ_data_name)=2, lsize($occ_data_name)=2, rgb($occ_data_name)=(red,green,blue)
		appendtograph /r $occ_fit_name
		ModifyGraph mode($occ_fit_name)=0, lsize($occ_fit_name)=2, rgb($occ_fit_name)=(red,green,blue)
		
		////////////////////////////////////////
		/////// Creating Conductance fit ///////
		////////////////////////////////////////
		cond_data_name = stringfromlist(i,data.g_wvlist)
		if ((fit_conductance == 1) || (global_fit_conductance == 1))
			if (global_fit_conductance == 0)
				cond_fit_name = "fit_" + cond_data_name
				cond_coef_name = "coef_" + cond_data_name
				
				make/o /n=5 $cond_coef_name = 0 
				wave cond_coef = $cond_coef_name
				cond_coef[0,4] = cs_coef[p]
				cond_coef[4] = 1
				
				duplicate /o $cond_data_name $cond_fit_name
	
				FuncFit/Q/TBOX=768/H="11010" fitfunc_nrgcondAAO cond_coef $cond_data_name /D=$cond_fit_name
			else
				cond_fit_name = "Gfit_" + cond_data_name
			endif
			
			// add conduction to graph
			appendtograph /l $cond_data_name
			ModifyGraph mode($cond_data_name)=2, lsize($cond_data_name)=2, rgb($cond_data_name)=(red,green,blue)
			appendtograph /l $cond_fit_name
			ModifyGraph mode($cond_fit_name)=0, lsize($cond_fit_name)=2, rgb($cond_fit_name)=(red,green,blue)
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

			make/o /n=8 $cold_entropy_coef_name = 0 // Make coefficient wave for occupation fits
			wave cold_entropy_coef = $cold_entropy_coef_name
			cold_entropy_coef[0,7] = cs_coef[p]
			
			
			cold_entropy_coef[5] = 0
			cold_entropy_coef[6] = 0
			cold_entropy_coef[7] = -(wavemax($cold_entropy_data_name) - wavemin($cold_entropy_data_name))/2 // amplitude
			
			duplicate /o $cold_entropy_data_name $cold_entropy_fit_name
			
			if (waveexists($cold_entropy_mask_name) == 1)
				wave cold_entropy_mask_wave = $cold_entropy_mask_name 
			else
				duplicate /o $cold_entropy_data_name $cold_entropy_mask_name
				wave cold_entropy_mask_wave = $cold_entropy_mask_name
				cold_entropy_mask_wave = 1
			endif
			
			
			FuncFit/Q/TBOX=768/H="11010110" fitfunc_nrgctAAO cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name
			FuncFit/Q/TBOX=768/H="11010010" fitfunc_nrgctAAO cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name
			FuncFit/Q/TBOX=768/H="11010000" fitfunc_nrgctAAO cold_entropy_coef $cold_entropy_data_name /D=$cold_entropy_fit_name /M=cold_entropy_mask_wave
			
			
			//////////////////////////////////////////////////////
			///// SECOND FIT TO HOT TRANSITIONS FROM ENTROPY //////
			//////////////////////////////////////////////////////
			hot_entropy_base_name = "dat" +  stringfromlist(i, fit_entropy_dats) + "_cs_cleaned_hot_avg"
			hot_entropy_data_name = hot_entropy_base_name
			hot_entropy_coef_name = "coef_" + hot_entropy_base_name
			hot_entropy_fit_name = "fit_" + hot_entropy_base_name

			make/o /n=8 $hot_entropy_coef_name = 0 // Make coefficient wave for occupation fits
			wave hot_entropy_coef = $hot_entropy_coef_name
			hot_entropy_coef[0,7] = cold_entropy_coef[p]
			
			duplicate /o $hot_entropy_data_name $hot_entropy_fit_name
			
			// hold everything except x-scaling and x-offset
			FuncFit/Q/H="11001111" fitfunc_nrgctAAO hot_entropy_coef $hot_entropy_data_name /D=$hot_entropy_fit_name
			
			scaling_dt = (data.temps[0]/exp(hot_entropy_coef[3])) - (data.temps[0]/exp(cold_entropy_coef[3]))
			scaling_amplitude = hot_entropy_coef[7] + cold_entropy_coef[7]
			scaling_factor = abs(1 / scaling_amplitude / scaling_dt)
			print "dt = " + num2str(scaling_dt)
			print "percent T = " + num2str((data.temps[0]/exp(hot_entropy_coef[3]))/(data.temps[0]/exp(cold_entropy_coef[3])))
			print "Amplitude = " + num2str(scaling_amplitude)
			print "Scaling Factor = " + num2str(scaling_factor)
			
			
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
			create_x_wave($occ_fit_name)
			wave x_wave
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
//			display $entropy_data_name
			 
			smooth 200, entropy_data
			
			
//			wavestats /q entropy_data;
			entropy_y_offset = mean($entropy_data_name, pnt2x($entropy_data_name, 0), pnt2x($entropy_data_name, dimsize(entropy_data, 0)/4))
			
			entropy_data -= entropy_y_offset
			variable  entropy_y_mul = wavemax(entropy_data,  pnt2x(entropy_data, 9*dimsize(entropy_data, 0)/20), pnt2x(entropy_data, 19*dimsize(entropy_data, 0)/20))
			entropy_data /= entropy_y_mul
			
			entropy_coef[0,3] = cold_entropy_coef[p]; entropy_coef[4]=0;  entropy_coef[5]=0; entropy_coef[6]=0; entropy_coef[7]=1;
			duplicate /o $cold_entropy_fit_name $entropy_fit_name
			wave entropy_fit = $entropy_fit_name
			
//			create_x_wave($cs_fit_name)
//			wave x_wave
			
//			Interpolate2/T=1/E=2/Y=entropy_fit/I=3 entropy_data //linear interpolation // T=1: Linear || E=2: Match 2nd derivative || I=3:gives output at x-coords specified (destination must be created)|| Y=destination wave ||

//			FuncFit/Q/H="11010110" fitfunc_nrgentropyAAO entropy_coef entropy_data /D // /M=$(stringfromlist(i,data.occ_maskwvlist))
			FuncFit/Q/H="11111110" fitfunc_nrgentropyAAO entropy_coef $entropy_data_name /D=entropy_fit  ///M=$(stringfromlist(i,data.occ_maskwvlist)) 
		
//			entropy_y_mul = wavemax(entropy_fit,  pnt2x(entropy_fit, 9*dimsize(entropy_fit, 0)/20), pnt2x(entropy_fit, 19*dimsize(entropy_fit, 0)/20))
//			entropy_fit /= entropy_y_mul
			/////////////////////////////////////////////
			///// FIFTH INTEGRATE ENTROPY AND SCALE /////
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
		endif
	endfor
	
//	print "Chisqr on occupation fit is " + num2str(total_cs_chisq/4)
	occ_chisq = total_cs_chisq/4 /// NOTE: Poorly named variable, this should be cs 


	
	
	
	//// CONDUCTANCE VS OCCUPATION /////
//	////////////////////////////////////////////////////
//	///// Creating Occupation and Plotting Conductance vs. Occupation Data /////
//	////////////////////////////////////////////////////
//	// Use coefficients determined from occupations fit to find occupation(Vgate)
//	// create NRG occupation wave with same x-scaling as data conductance
//	// create data conduction curve 
//	string cond_vs_occ_data_wave_name
//	display
//	for(i=0;i<numwvs;i++)
//		wavenm = stringfromlist(i,data.g_wvlist) + "_occ_nrg" // create a new name XXX_occ_nrg where XXX is the name of the conductance wave used in the NRG fitting
//
//		duplicate /o $(stringfromlist(i,data.g_wvlist)) $wavenm // copy the conductance wave into nrgocc_XXX, in the end just to use its x-scaling
//		wave nrg_occ = $wavenm // call this wave nrg_occ for use in this function
//		
//		wavenm = "coef_" + stringfromlist(i,data.occ_wvlist)
//		fitfunc_nrgocc($wavenm, nrg_occ) // overwrite nrg_occ using occupation fit params and NRG occupation (keep same x-scaling as conduction)
//		
//		string cond_vs_occ_ydata_wave_name = stringfromlist(i,data.g_wvlist)
//
//		// NEW WAY //
////		crop_waves_by_x_scaling($cond_vs_occ_data_wave_name, wave2)
//		
//		// OLD WAY //
////		prune_waves($cond_vs_occ_ydata_wave_name, nrg_occ)
//		appendtograph $cond_vs_occ_ydata_wave_name vs nrg_occ
//		ModifyGraph mode($cond_vs_occ_ydata_wave_name)=2, lsize($cond_vs_occ_ydata_wave_name)=2, rgb($cond_vs_occ_ydata_wave_name)=(0,0,0)
//	
//	
//		///// creating occupation data wave /////
//		
//	
//		///// saving occupation fit data from GFfit_XXX to fit_XXX this is same naming scheme with how charge transitions are saved
//		wavenm = "GFit_" + stringfromlist(i,data.g_wvlist)
//		newwavenm = "fit_" + stringfromlist(i,data.g_wvlist)
//		duplicate /o $wavenm $newwavenm
//	endfor
	
//		
//	// Add NRG data on top
//	for(i=0;i<numwvs;i++)
//		wavenm="coef_" + stringfromlist(i,data.g_wvlist)
//		string cond_vs_occ_xnrg_wave_name = stringfromlist(i,data.g_wvlist) + "_occ_nrg"
//		string cond_vs_occ_ynrg_wave_name = stringfromlist(i,data.g_wvlist) + "_cond_nrg"
//		
//		wave g_coefs = $wavenm
//		wave g_nrg
//		wave occ_nrg
//		nrgline = scaletoindex(g_nrg, (g_coefs[0] + g_coefs[3]), 1)
//		wavenm = "g" + num2str(nrgline)
//		matrixop /o $wavenm=col(g_nrg, nrgline)
//		wave gnrg = $wavenm
//		gnrg *= g_coefs[4]
//
//		// save NRG conduction
//		duplicate /o gnrg, $cond_vs_occ_ynrg_wave_name
//		
//		// save x-wave (alrady saved above)
//		duplicate /RMD=[][nrgline] /o occ_nrg, $cond_vs_occ_xnrg_wave_name
//		
//		
//		appendtograph $cond_vs_occ_ynrg_wave_name vs $cond_vs_occ_xnrg_wave_name
//		wave cond_vs_occ_nrg_wave_y = $cond_vs_occ_ynrg_wave_name
//		
//		
//		///// calculate chi2 /////
//		cond_vs_occ_data_wave_name = stringfromlist(i,data.g_wvlist)
//		wave cond_vs_occ_data_wave = $cond_vs_occ_data_wave_name
//		
//		duplicate /o cond_vs_occ_data_wave, cond_vs_occ_calc
//		wave cond_vs_occ_calc 
//		cond_vs_occ_calc = (cond_vs_occ_data_wave - cond_vs_occ_nrg_wave_y)^2
//		condocc_chisq += sum(cond_vs_occ_calc)
//	endfor
//	
	return [cond_chisq, occ_chisq, condocc_chisq/4]
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
Function fitfunc_nrgcond(w,x) : FitFunc
	Wave w
	Variable x
	wave nrg=m_interpolatedimage

	return interp2d(nrg,(w[1]*(x-w[2])),(w[0]+w[3]))
End


Function fitfunc_nrgcondAAO(pw, yw, xw) : FitFunc // original negative
	WAVE pw, yw, xw
	wave nrg = g_nrg
	// coef[0]: lnG/T for Tbase -- linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: ln(T/Tbase) for different waves
	// coef[4]: peak height
	
	yw = pw[4] * interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3]))
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
	
	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2
end



Function fitfunc_nrgctAAO_tbasevary(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	wave nrg = occ_nrg
	// coef[0]: Tbase --linked
	// coef[1]: x-scaling -- linked
	// coef[2]: x-offset
	// coef[3]: gamma -- linked
	// coef[4]: const offset
	// coef[5]: linear
	// coef[6]: quadratic
	// coef[7]: amplitude
	// coef[8]: Tmeasure
	
	yw = pw[7]*interp2d(nrg, (pw[1] * (xw - pw[2])), (ln(pw[3]/pw[0]) + ln(pw[0]/pw[8]))) + pw[4] + pw[5]*xw + pw[6]*xw^2
end



Function fitfunc_nrgocc(pw, yw) : FitFunc
	WAVE pw, yw
	wave nrg=occ_nrg
	
	yw = interp2d(nrg, (pw[1]*(x-pw[2])), (pw[0]+pw[3]))
//	yw = interp2d(nrg, x, (pw[0]+pw[3]))
end


Function fitfunc_ct_to_occ(pw, yw, xw) : FitFunc
	WAVE pw, yw, xw
	wave nrg=occ_nrg
	
//	yw = pw[7]*interp2d(nrg, (pw[1]*(xw-pw[2])), (pw[0] + pw[3])) + pw[4] + pw[5]*xw + pw[6]*xw^2
	
	yw[] = yw[p] - (pw[4] + pw[5]*xw[p] + pw[6]*xw[p]^2)
	yw[] = yw[p]/pw[7]
	
//	xw[] = xw[p]/pw[1]
//	xw[] = xw[p] + pw[2]
	
	SetScale/I x pnt2x(xw, 0), pnt2x(xw, dimsize(xw, 0) - 1), yw
end


/////////////////////////////
///// entropy functions /////
/////////////////////////////
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