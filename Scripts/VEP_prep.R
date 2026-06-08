library(tidyverse)

tada_vcf <- dn_tada %>%
  select(chrom, pos, ref, alt) %>%
  mutate(chrom = str_remove(chrom, "chr")) %>%
  mutate(id = ".", qual = ".",  filter = ".",  info = ".") %>%
  select(chrom, pos, id, ref, alt, qual, filter, info)

write.table(tada_vcf, file = "tada.vcf", sep = "\t", row.names = FALSE, quote = FALSE)


'
--per_gene --pick --pick_order canonical,appris,tsl,biotype,ccds,rank,length \

singularity run vep_local_name.sif \
  vep \
    --offline --cache \
    -i tester.vcf \
    -o output.txt \
    --verbose \
    --format vcf --tab \
    --transcript_version \
    --ccds --numbers \
    --af_1kg --af_gnomad --max_af --no_stats \
    --mane --canonical --domains --protein --biotype --uniprot --tsl --appris \
    --pubmed \
    --regulatory \
    --symbol \
    --fork 6 \
    --plugin dbNSFP,dbNSFP5.3.1a_grch38.gz,SIFT_score,SIFT_converted_rankscore,SIFT_pred,SIFT4G_score,SIFT4G_converted_rankscore,SIFT4G_pred,Polyphen2_HDIV_score,Polyphen2_HDIV_rankscore,Polyphen2_HDIV_pred,Polyphen2_HVAR_score,Polyphen2_HVAR_rankscore,Polyphen2_HVAR_pred,MutationTaster_score,MutationTaster_rankscore,MutationTaster_pred,MutationTaster_model,MutationTaster_trees_benign,MutationTaster_trees_deleterious,MutationAssessor_score,MutationAssessor_rankscore,MutationAssessor_pred,PROVEAN_score,PROVEAN_converted_rankscore,PROVEAN_pred,VEST4_score,VEST4_rankscore,MetaSVM_score,MetaSVM_rankscore,MetaSVM_pred,MetaLR_score,MetaLR_rankscore,MetaLR_pred,Reliability_index,MetaRNN_score,MetaRNN_rankscore,MetaRNN_pred,M-CAP_score,M-CAP_rankscore,M-CAP_pred,REVEL_score,REVEL_rankscore,MutPred2_score,MutPred2_rankscore,MutPred2_pred,MutPred2_top5_mechanisms,MisFit_D_score,MisFit_D_pred_lenient,MisFit_D_pred_stringent,MisFit_D_rankscore,MisFit_S_score,MisFit_S_rankscore,MVP_score,MVP_rankscore,gMVP_score,gMVP_rankscore,MPC_score,MPC_rankscore,PrimateAI_score,PrimateAI_rankscore,PrimateAI_pred,DEOGEN2_score,DEOGEN2_rankscore,DEOGEN2_pred,BayesDel_addAF_score,BayesDel_addAF_rankscore,BayesDel_addAF_pred,BayesDel_noAF_score,BayesDel_noAF_rankscore,BayesDel_noAF_pred,ClinPred_score,ClinPred_rankscore,ClinPred_pred,LIST-S2_score,LIST-S2_pred,LIST-S2_rankscore,VARITY_R_score,VARITY_R_rankscore,VARITY_ER_score,VARITY_ER_rankscore,VARITY_R_LOO_score,VARITY_R_LOO_rankscore,VARITY_ER_LOO_score,VARITY_ER_LOO_rankscore,ESM1b_score,ESM1b_converted_rankscore,ESM1b_pred,AlphaMissense_score,AlphaMissense_rankscore,AlphaMissense_pred,PHACTboost_score,PHACTboost_rankscore,MutFormer_score,MutFormer_rankscore,MutScore_score,MutScore_rankscore,popEVE_score,popEVE_converted_rankscore,popEVE_pred,Aloft_Fraction_transcripts_affected,Aloft_prob_Tolerant,Aloft_prob_Recessive,Aloft_prob_Dominant,Aloft_pred,Aloft_Confidence,CADD_raw,CADD_raw_rankscore,CADD_phred,DANN_score,DANN_rankscore,fathmm-XF_coding_score,fathmm-XF_coding_rankscore,fathmm-XF_coding_pred,Eigen-raw_coding,Eigen-raw_coding_rankscore,Eigen-phred_coding,Eigen-PC-raw_coding,Eigen-PC-raw_coding_rankscore,Eigen-PC-phred_coding,GERP++_NR,GERP++_RS,GERP++_RS_rankscore,phyloP100way_vertebrate,phyloP100way_vertebrate_rankscore,phyloP470way_mammalian,phyloP470way_mammalian_rankscore,phyloP17way_primate,phyloP17way_primate_rankscore,phastCons100way_vertebrate,phastCons100way_vertebrate_rankscore,phastCons470way_mammalian,phastCons470way_mammalian_rankscore,phastCons17way_primate,phastCons17way_primate_rankscore,bStatistic,bStatistic_converted_rankscore

'


