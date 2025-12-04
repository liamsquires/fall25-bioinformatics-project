##############################################################
# Author: Marek Cmero
##############################################################
'''
Module      : create_kallisto_ec_count_matrix
Description : Create equivalence class matrix from kallisto.
Copyright   : (c) Marek Cmero, Dec 2018
License     : MIT
Maintainer  : MAREK.CMERO@MCRI.EDU.AU
Portability : POSIX
Take equivalence class output from kallisto's batch mode
(matrix.ec) and create an EC matrix that can be used for DE/DTU
'''

import os
import argparse
import re
import pandas as pd
import numpy as np
import gc

parser = argparse.ArgumentParser()
parser.add_argument(dest='ec_file', help="Kallisto equivalence class file (matrix.ec).")
parser.add_argument(dest='counts_file', help="Kallisto counts file (matrix.tsv).")
parser.add_argument(dest='samples_file', help="Kallisto samples file (matrix.cells).")
parser.add_argument(dest='tx_ids_file',
                    help='''File containing one transcript ID per line,
                            in same order as the fasta reference used for kallisto.''')
parser.add_argument(dest='out_file', help="Output file.")
args = parser.parse_args()

ec_file         = args.ec_file
counts_file     = args.counts_file
samples_file    = args.samples_file
tx_ids_file     = args.tx_ids_file
out_file        = args.out_file

ec_df    = pd.read_csv(ec_file, header=None, sep='\t', names=['ec_names', 'tx_ids'])
counts   = pd.read_csv(counts_file, header=None, sep='\t', names=['ec_names', 'sample_id', 'count'])
samples  = pd.read_csv(samples_file, header=None, sep='\t')[0].values
tx_ids   = pd.read_csv(tx_ids_file, header=None)[0].values

print('restructuring EC counts...')
counts = pd.merge(counts, ec_df, on='ec_names')
counts = counts.pivot_table(index=['ec_names', 'tx_ids'], columns=['sample_id'], fill_value=0)
counts = counts.reset_index()
counts.columns = counts.columns.droplevel()
counts.columns = np.concatenate([['ec_names', 'tx_ids'], samples])

print('separating transcript IDs...')
ec_tmp = ec_df[ec_df.ec_names.isin(counts.ec_names)]
tx_stack = ec_tmp['tx_ids'].str.split(',').apply(pd.Series,1).stack()
tx_stack = pd.DataFrame(tx_stack, columns=['tx_id'])
tx_stack['ec_names'] = [i[0] for i in tx_stack.index]

counts = pd.merge(counts, tx_stack, left_on='ec_names', right_on='ec_names')
counts['ec_names'] = counts.ec_names.apply(lambda x: 'ec%s' % x)
counts['transcript'] = tx_ids[counts.tx_id.map(int).values]
counts = counts[np.concatenate([samples, ['ec_names', 'tx_id', 'transcript']])]

print('writing output...')
counts.to_csv(out_file, sep='\t', index=False)
