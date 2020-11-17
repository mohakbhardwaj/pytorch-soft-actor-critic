# python main.py --env-name pen-v0 --num_steps 10000000 --eval_episodes 30 --eval_freq 40 --seed 0 --test_seed 999 --automatic_entropy_tuning True --cuda --hidden_size 64
# python main.py --env-name pen-v0 --num_steps 10000000 --eval_episodes 30 --eval_freq 40 --seed 123 --test_seed 999 --automatic_entropy_tuning True --cuda --hidden_size 64
python main.py --env-name pen-v0 --num_steps 10000000 --eval_episodes 30 --eval_freq 40 --seed 12345 --test_seed 999 --automatic_entropy_tuning True --cuda --hidden_size 64
