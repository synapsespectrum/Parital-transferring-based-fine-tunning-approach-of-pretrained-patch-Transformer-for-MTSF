#export CUDA_VISIBLE_DEVICES=1

for i in 24 48 96 168 192 336 720; do
  echo "Starting to train model with output length = $i"
  python -u experiment.py \
    --is_training 1 \
    --root_path dataset/ \
    --data_path traffic.csv \
    --model Autoformer \
    --data Traffic \
    --freq h \
    --features M \
    --seq_len 96 \
    --label_len 48 \
    --pred_len $i \
    --e_layers 2 \
    --d_layers 1 \
    --factor 3 \
    --enc_in 862 \
    --dec_in 862 \
    --c_out 862 \
    --d_ff 512 \
    --des Exp \
    --itr 2
  echo "Finished training model with output length = $i"
  echo "=================================================="
done
