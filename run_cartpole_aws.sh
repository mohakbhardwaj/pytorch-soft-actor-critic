#!/usr/bin/env bash
#Specify the command line parameters for all experiments to run
instance_ips=('ec2-54-215-234-170.us-west-1.compute.amazonaws.com')
# 'ec2-13-57-184-46.us-west-1.compute.amazonaws.com' 'ec2-54-215-234-170.us-west-1.compute.amazonaws.com' \
# 'ec2-3-101-25-48.us-west-1.compute.amazonaws.com'
seeds=(123)

run_seeds=(0) #idxs of environments to run
save_folder=.

for ((j=0;j<${#run_seeds[@]};++j)); do
	eidx=${run_seeds[j]}
	log_dir=${save_folder}/logs/${seeds[eidx]}/sac_logs/
	if [[ ! -e ${log_dir}/log.txt ]]; then
    	mkdir -p ${log_dir}
    	touch ${log_dir}/log.txt
		touch ${log_dir}/stderrlog.txt
	fi 
	local_log_file=${log_dir}/log.txt
	local_stderr_log_file=${log_dir}/log.txt

	printf "====Running SAC experiment with seed %s on instance with IP = %s ==== \n" ${seeds[eidx]} ${instance_ips[eidx]}	| tee -a ${local_log_file}
	ssh -i ~/mohak.pem ubuntu@${instance_ips[eidx]} screen -d -m "hostname && \
		source ~/anaconda3/bin/activate && \
		export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ubuntu/.mujoco/mujoco200/bin && \
		conda activate mpc_rl && \
		cd ~/workspace/pytorch-soft-actor-critic && \
        python main.py --env-name cartpole-v0 --num_steps 1000000 --eval_episodes 30 --eval_freq 40 --seed ${seeds[eidx]} --test_seed 999 --automatic_entropy_tuning True" | tee -a ${local_log_file} >/dev/null &

done

