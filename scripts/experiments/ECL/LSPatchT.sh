#export CUDA_VISIBLE_DEVICES=1

# building the pretrained model fpr LSPatchT
echo "Building the pretrained model for LSPatchT for electricity dataset with input length 96"
python -u experiment.py \
    --is_pretrain 1 \
    --is_training 1 \
    --batch_size 64 \
    --root_path dataset/ \
    --data_path electricity.csv \
    --checkpoints ./experiments/model_saved/checkpoints/ \
    --model LSPatchT \
    --model_id Pretrain \
    --data ECL \
    --freq h \
    --features M \
    --mask_ratio 0.4 \
    --patch_len 12 \
    --stride 12 \
    --seq_len 96 \
    --e_layers 2 \
    --d_layers 1 \
    --factor 3 \
    --enc_in 321 \
    --dec_in 321 \
    --c_out 321 \
    --des Exp \
    --itr 1

for i in 24 48 96 168 192 336 720; do
  echo "Starting to train model with output length = $i"
  python -u experiment.py \
    --is_training 1 \
    --is_finetune 1 \
    --batch_size 32 \
    --root_path dataset/ \
    --data_path electricity.csv \
    --model LSPatchT \
    --model_id FineTune \
    --data ECL \
    --checkpoints ./experiments/model_saved/checkpoints/ \
    --pretrained_model ./experiments/model_saved/checkpoints/Pretrain_LSPatchT_ECL_sl96_0/checkpoint.pth \
    --freq h \
    --features M \
    --seq_len 96 \
    --label_len 48 \
    --pred_len $i \
    --patch_len 96 \
    --stride 96 \
    --e_layers 2 \
    --d_layers 1 \
    --factor 3 \
    --enc_in 321 \
    --dec_in 321 \
    --c_out 321 \
    --des Exp \
    --itr 2
  echo "Finished training model with output length = $i"
  echo "=================================================="
done
