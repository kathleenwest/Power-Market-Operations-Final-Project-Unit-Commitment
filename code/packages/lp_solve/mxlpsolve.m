% mxlpsolve  Mex file interface to the lp_solve 5.1 toolkit. Please see
% reference guide for more information.
%
% mxlpsolve is a low-level interface to the lp_solve toolkit. It may be called
% directly, or may be used to build higher level functions for solving
% various kinds of linear and mixed-integer linear programs. It uses an
% integer handle to point to a linear program.
%
%     return = mxlpsolve('add_column', lp_handle, [column])
%
%     return = mxlpsolve('add_columnex', lp_handle, [column])
%
%     return = mxlpsolve('add_constraint', lp_handle, [row], constr_type, rh)
%
%     return = mxlpsolve('add_constraintex', lp_handle, [row], constr_type, rh)
%
%     return = mxlpsolve('add_SOS', lp_handle, name, sostype, priority, [sosvars], [weights])
%
%     return = mxlpsolve('column_in_lp', lp_handle, [column])
%
%     mxlpsolve('default_basis', lp_handle)
%
%     return = mxlpsolve('del_column', lp_handle, column)
%
%     return = mxlpsolve('del_constraint', lp_handle, del_row)
%
%     mxlpsolve('delete_lp', lp_handle)
%
%     mxlpsolve('free_lp', lp_handle)
%
%     return = mxlpsolve('get_anti_degen', lp_handle)
%
%     [bascolumn] = mxlpsolve('get_basis', lp_handle {, nonbasic})
%
%     return = mxlpsolve('get_basiscrash', lp_handle)
%
%     return = mxlpsolve('get_bb_depthlimit', lp_handle)
%
%     return = mxlpsolve('get_bb_floorfirst', lp_handle)
%
%     return = mxlpsolve('get_bb_rule', lp_handle)
%
%     return = mxlpsolve('get_bounds_tighter', lp_handle)
%
%     return = mxlpsolve('get_break_at_value', lp_handle)
%
%     name = mxlpsolve('get_col_name', lp_handle, column)
%
%     [names] = mxlpsolve('get_col_name', lp_handle)
%
%     [column, return] = mxlpsolve('get_column', lp_handle, col_nr)
%
%     return = mxlpsolve('get_constr_type', lp_handle, row)
%
%     [constr_type] = mxlpsolve('get_constr_type', lp_handle)
%
%     [constr, return] = mxlpsolve('get_constraints', lp_handle)
%
%     [duals, return] = mxlpsolve('get_dual_solution', lp_handle)
%
%     return = mxlpsolve('get_epsb', lp_handle)
%
%     return = mxlpsolve('get_epsd', lp_handle)
%
%     return = mxlpsolve('get_epsel', lp_handle)
%
%     return = mxlpsolve('get_epsint', lp_handle)
%
%     return = mxlpsolve('get_epsperturb', lp_handle)
%
%     return = mxlpsolve('get_epspivot', lp_handle)
%
%     return = mxlpsolve('get_improve', lp_handle)
%
%     return = mxlpsolve('get_infinite', lp_handle)
%
%     return = mxlpsolve('get_lowbo', lp_handle, column)
%
%     [return] = mxlpsolve('get_lowbo', lp_handle)
%
%     return = mxlpsolve('get_lp_index', lp_handle, orig_index)
%
%     name = mxlpsolve('get_lp_name', lp_handle)
%
%     value = mxlpsolve('get_mat', lp_handle, row, col)
%
%     [matrix, return] = mxlpsolve('get_mat', lp_handle)
%
%     return = mxlpsolve('get_max_level', lp_handle)
%
%     return = mxlpsolve('get_maxpivot', lp_handle)
%
%     return = mxlpsolve('get_mip_gap', lp_handle, absolute)
%
%     return = mxlpsolve('get_nameindex', lp_handle, name, isrow)
%
%     return = mxlpsolve('get_Ncolumns', lp_handle)
%
%     return = mxlpsolve('get_negrange', lp_handle)
%
%     return = mxlpsolve('get_nonzeros', lp_handle)
%
%     return = mxlpsolve('get_Norig_columns', lp_handle)
%
%     return = mxlpsolve('get_Norig_rows', lp_handle)
%
%     return = mxlpsolve('get_Nrows', lp_handle)
%
%     return = mxlpsolve('get_obj_bound', lp_handle)
%
%     [row_vec, return] = mxlpsolve('get_obj_fn', lp_handle)
%
%     [row_vec, return] = mxlpsolve('get_obj_fun', lp_handle)
%
%     return = mxlpsolve('get_objective', lp_handle)
%
%     name = mxlpsolve('get_objective_name', lp_handle)
%
%     return = mxlpsolve('get_orig_index', lp_handle, lp_index)
%
%     name = mxlpsolve('get_origcol_name', lp_handle, column)
%
%     [names] = mxlpsolve('get_origcol_name', lp_handle)
%
%     name = mxlpsolve('get_origrow_name', lp_handle, row)
%
%     [names] = mxlpsolve('get_origrow_name', lp_handle)
%
%     return = mxlpsolve('get_pivoting', lp_handle)
%
%     return = mxlpsolve('get_presolve', lp_handle)
%
%     [pv, return] = mxlpsolve('get_primal_solution', lp_handle)
%
%     return = mxlpsolve('get_print_sol', lp_handle)
%
%     return = mxlpsolve('get_rh', lp_handle, row)
%
%     [rh] = mxlpsolve('get_rh', lp_handle)
%
%     return = mxlpsolve('get_rh_range', lp_handle, row)
%
%     [rh_ranges] = mxlpsolve('get_rh_range', lp_handle)
%
%     [row, return] = mxlpsolve('get_row', lp_handle, row_nr)
%
%     name = mxlpsolve('get_row_name', lp_handle, row)
%
%     [names] = mxlpsolve('get_row_name', lp_handle)
%
%     return = mxlpsolve('get_scalelimit', lp_handle)
%
%     return = mxlpsolve('get_scaling', lp_handle)
%
%     [objfrom, objtill, objfromvalue, objtillvalue, return] = mxlpsolve('get_sensitivity_obj', lp_handle)
%
%     [objfrom, objtill, objfromvalue, objtillvalue, return] = mxlpsolve('get_sensitivity_objex', lp_handle)
%
%     [duals, dualsfrom, dualstill, return] = mxlpsolve('get_sensitivity_rhs', lp_handle)
%
%     [duals, dualsfrom, dualstill, return] = mxlpsolve('get_sensitivity_rhsex', lp_handle)
%
%     return = mxlpsolve('get_simplextype', lp_handle)
%
%     [obj, x, duals, return] = mxlpsolve('get_solution', lp_handle)
%
%     return = mxlpsolve('get_solutioncount', lp_handle)
%
%     return = mxlpsolve('get_solutionlimit', lp_handle)
%
%     return = mxlpsolve('get_status', lp_handle)
%
%     return = mxlpsolve('get_statustext', lp_handle, statuscode)
%
%     return = mxlpsolve('get_timeout', lp_handle)
%
%     return = mxlpsolve('get_total_iter', lp_handle)
%
%     return = mxlpsolve('get_total_nodes', lp_handle)
%
%     return = mxlpsolve('get_upbo', lp_handle, column)
%
%     [upbo] = mxlpsolve('get_upbo', lp_handle)
%
%     return = mxlpsolve('get_var_branch', lp_handle, column)
%
%     [var_branch] = mxlpsolve('get_var_branch', lp_handle)
%
%     return = mxlpsolve('get_var_dualresult', lp_handle, index)
%
%     return = mxlpsolve('get_var_primalresult', lp_handle, index)
%
%     return = mxlpsolve('get_var_priority', lp_handle, column)
%
%     [var_priority] = mxlpsolve('get_var_priority', lp_handle)
%
%     [var, return] = mxlpsolve('get_variables', lp_handle)
%
%     return = mxlpsolve('get_verbose', lp_handle)
%
%     return = mxlpsolve('get_working_objective', lp_handle)
%
%     return = mxlpsolve('has_BFP', lp_handle)
%
%     return = mxlpsolve('has_XLI', lp_handle)
%
%     return = mxlpsolve('is_add_rowmode', lp_handle)
%
%     return = mxlpsolve('is_anti_degen', lp_handle, testmask)
%
%     return = mxlpsolve('is_binary', lp_handle, column)
%
%     [binary] = mxlpsolve('is_binary', lp_handle)
%
%     return = mxlpsolve('is_break_at_first', lp_handle)
%
%     return = mxlpsolve('is_constr_type', lp_handle, row, mask)
%
%     return = mxlpsolve('is_debug', lp_handle)
%
%     return = mxlpsolve('is_feasible', lp_handle, [values] {, threshold})
%
%     return = mxlpsolve('is_free', lp_handle, column)
%
%     [free] = mxlpsolve('is_free', lp_handle)
%
%     return = mxlpsolve('is_infinite', lp_handle, value)
%
%     return = mxlpsolve('is_int', lp_handle, column)
%
%     [int] = mxlpsolve('is_int', lp_handle)
%
%     return = mxlpsolve('is_integerscaling', lp_handle)
%
%     return = mxlpsolve('is_maxim', lp_handle)
%
%     return = mxlpsolve('is_nativeBFP', lp_handle)
%
%     return = mxlpsolve('is_nativeXLI', lp_handle)
%
%     return = mxlpsolve('is_negative', lp_handle, column)
%
%     [negative] = mxlpsolve('is_negative', lp_handle)
%
%     return = mxlpsolve('is_piv_mode', lp_handle, testmask)
%
%     return = mxlpsolve('is_piv_rule', lp_handle, rule)
%
%     return = mxlpsolve('is_presolve', lp_handle, testmask)
%
%     return = mxlpsolve('is_scalemode', lp_handle, testmask)
%
%     return = mxlpsolve('is_scaletype', lp_handle, scaletype)
%
%     return = mxlpsolve('is_semicont', lp_handle, column)
%
%     [semicont] = mxlpsolve('is_semicont', lp_handle)
%
%     return = mxlpsolve('is_SOS_var', lp_handle, column)
%
%     [SOS_var] = mxlpsolve('is_SOS_var', lp_handle)
%
%     return = mxlpsolve('is_trace', lp_handle)
%
%     versionstring = mxlpsolve('lp_solve_version')
%
%     lp_handle = mxlpsolve('make_lp', rows, columns)
%
%     mxlpsolve('print_constraints', lp_handle {, columns})
%
%     return = mxlpsolve('print_debugdump', lp_handle, filename)
%
%     mxlpsolve('print_duals', lp_handle)
%
%     mxlpsolve('print_lp', lp_handle)
%
%     mxlpsolve('print_objective', lp_handle)
%
%     mxlpsolve('print_scales', lp_handle)
%
%     mxlpsolve('print_solution', lp_handle {, columns})
%
%     mxlpsolve('print_str', lp_handle, str)
%
%     mxlpsolve('print_tableau', lp_handle)
%
%     [handle_vec] = mxlpsolve('print_handle')
%
%     lp_handle = mxlpsolve('read_freeMPS', filename {, verbose})
%
%     lp_handle = mxlpsolve('read_lp_file', filename {, verbose {, lp_name}})
%
%     lp_handle = mxlpsolve('read_lp', filename {, verbose {, lp_name}})
%
%     lp_handle = mxlpsolve('read_LP', filename {, verbose {, lp_name}})
%
%     lp_handle = mxlpsolve('read_mps', filename {, verbose})
%
%     lp_handle = mxlpsolve('read_MPS', filename {, verbose})
%
%     lp_handle = mxlpsolve('read_XLI', xliname, modelname {, dataname {, options {, verbose}}}
%
%     return = mxlpsolve('set_add_rowmode', lp_handle, turnon)
%
%     mxlpsolve('set_anti_degen', lp_handle, anti_degen)
%
%     return = mxlpsolve('set_basis', lp_handle, [bascolumn], nonbasic)
%
%     mxlpsolve('set_basiscrash', lp_handle, mode)
%
%     mxlpsolve('set_bb_depthlimit', lp_handle, bb_maxlevel)
%
%     mxlpsolve('set_bb_floorfirst', lp_handle, bb_floorfirst)
%
%     mxlpsolve('set_bb_rule', lp_handle, bb_rule)
%
%     return = mxlpsolve('set_BFP', lp_handle, filename)
%
%     return = mxlpsolve('set_binary', lp_handle, column, must_be_bin)
%
%     return = mxlpsolve('set_binary', lp_handle, [must_be_bin])
%
%     return = mxlpsolve('set_bounds', lp_handle, column, lower, upper)
%
%     return = mxlpsolve('set_bounds', lp_handle, [lower], [upper])
%
%     mxlpsolve('set_bounds_tighter', lp_handle, tighten)
%
%     mxlpsolve('set_break_at_first', lp_handle, break_at_first)
%
%     mxlpsolve('set_break_at_value', lp_handle, break_at_value)
%
%     return = mxlpsolve('set_col_name', lp_handle, column, name)
%
%     return = mxlpsolve('set_col_name', lp_handle, [names])
%
%     return = mxlpsolve('set_column', lp_handle, col_no, [column])
%
%     return = mxlpsolve('set_columnex', lp_handle, col_no, [column])
%
%     return = mxlpsolve('set_constr_type', lp_handle, row, con_type)
%
%     return = mxlpsolve('set_constr_type', lp_handle, [con_type])
%
%     mxlpsolve('set_debug', lp_handle, debug)
%
%     mxlpsolve('set_epsb', lp_handle, epsb)
%
%     mxlpsolve('set_epsd', lp_handle, epsd)
%
%     mxlpsolve('set_epsel', lp_handle, epsel)
%
%     mxlpsolve('set_epsint', lp_handle, epsint)
%
%     mxlpsolve('set_epsperturb', lp_handle, epsperturb)
%
%     mxlpsolve('set_epspivot', lp_handle, epspivot)
%
%     return = mxlpsolve('set_free', lp_handle, column)
%
%     mxlpsolve('set_improve', lp_handle, improve)
%
%     mxlpsolve('set_infinite', lp_handle, infinite)
%
%     return = mxlpsolve('set_int', lp_handle, column, must_be_int)
%
%     return = mxlpsolve('set_int', lp_handle, [must_be_int])
%
%     return = mxlpsolve('set_lowbo', lp_handle, column, value)
%
%     return = mxlpsolve('set_lowbo', lp_handle, [values])
%
%     return = mxlpsolve('set_lp_name', lp_handle, name)
%
%     return = mxlpsolve('set_mat', lp_handle, [matrix])
%
%     return = mxlpsolve('set_mat', lp_handle, row, column, value)
%
%     mxlpsolve('set_maxim', lp_handle)
%
%     mxlpsolve('set_maxpivot', max_num_inv)
%
%     mxlpsolve('set_minim', lp_handle)
%
%     mxlpsolve('set_mip_gap', lp_handle, absolute, mip_gap)
%
%     mxlpsolve('set_negrange', negrange)
%
%     return = mxlpsolve('set_obj', lp_handle, column, value)
%
%     return = mxlpsolve('set_obj', lp_handle, [values])
%
%     mxlpsolve('set_obj_bound', lp_handle, obj_bound)
%
%     return = mxlpsolve('set_obj_fn', lp_handle, [row])
%
%     return = mxlpsolve('set_obj_fnex', lp_handle, [row])
%
%     return = mxlpsolve('set_outputfile', lp_handle, filename)
%
%     mxlpsolve('set_pivoting', lp_handle, pivoting)
%
%     mxlpsolve('set_preferdual', lp_handle, dodual)
%
%     mxlpsolve('set_presolve', lp_handle, do_presolve)
%
%     mxlpsolve('set_print_sol', lp_handle, print_sol)
%
%     return = mxlpsolve('set_rh', lp_handle, row, value)
%
%     return = mxlpsolve('set_rh', lp_handle, [values])
%
%     return = mxlpsolve('set_rh_range', lp_handle, row, deltavalue)
%
%     return = mxlpsolve('set_rh_range', lp_handle, [deltavalues])
%
%     mxlpsolve('set_rh_vec', lp_handle, [rh])
%
%     return = mxlpsolve('set_row', lp_handle, row_no, [row])
%
%     return = mxlpsolve('set_rowex', lp_handle, row_no, [row])
%
%     return = mxlpsolve('set_row_name', lp_handle, row, name)
%
%     return = mxlpsolve('set_row_name', lp_handle, [names])
%
%     mxlpsolve('set_scalelimit', lp_handle, scalelimit)
%
%     mxlpsolve('set_scaling', lp_handle, scalemode)
%
%     return = mxlpsolve('set_semicont', lp_handle, column, must_be_sc)
%
%     return = mxlpsolve('set_semicont', lp_handle, [must_be_sc])
%
%     mxlpsolve('set_sense', lp_handle, maximize)
%
%     mxlpsolve('set_simplextype', lp_handle, simplextype)
%
%     mxlpsolve('set_solutionlimit', lp_handle, simplextype)
%
%     mxlpsolve('set_timeout', lp_handle, sectimeout)
%
%     mxlpsolve('set_trace', lp_handle, trace)
%
%     return = mxlpsolve('set_upbo', lp_handle, column, value)
%
%     return = mxlpsolve('set_upbo', lp_handle, [values])
%
%     return = mxlpsolve('set_var_branch', lp_handle, column, branch_mode)
%
%     return = mxlpsolve('set_var_branch', lp_handle, [branch_mode])
%
%     return = mxlpsolve('set_var_weights', lp_handle, [weights])
%
%     mxlpsolve('set_verbose', lp_handle, verbose)
%
%     return = mxlpsolve('set_XLI', lp_handle, filename)
%
%     result = mxlpsolve('solve', lp_handle)
%
%     return = mxlpsolve('time_elapsed', lp_handle)
%
%     mxlpsolve('unscale', lp_handle)
%
%     return = mxlpsolve('write_freemps', lp_handle, filename)
%
%     return = mxlpsolve('write_freeMPS', lp_handle, filename)
%
%     return = mxlpsolve('write_lp', lp_handle, filename)
%
%     return = mxlpsolve('write_LP', lp_handle, filename)
%
%     return = mxlpsolve('write_mps', lp_handle, filename)
%
%     return = mxlpsolve('write_MPS', lp_handle, filename)
%
%     return = mxlpsolve('write_XLI', lp_handle, filename {, options {, results}})
%

disp('mxlpsolve driver not found !!!');
disp('Check if mxlpsolve.dll is on your system and in a directory known to MATLAB.');
disp('Press enter to see the paths where MATLAB looks for the driver.');
pause
path
disp('A path can be added via the menu: File, Set Path');
error('mxlpsolve.dll not found');
