## This is just a list of useful stuff

### set up autocomplete and alias for powershell

Set-Alias -Name k -Value kubectl
kubectl completion powershell | Out-String | Invoke-Expression
Register-ArgumentCompleter -CommandName k -ScriptBlock $__kubectlCompleterBlock

### quick reference kubectl and autocomplete for bash

https://kubernetes.io/docs/reference/kubectl/quick-reference/

source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

alias k=kubectl
complete -o default -F __start_kubectl k

### useful pods to have there for troubleshooting purposes

k run nettools --image someguy123/net-tools
k run busybox --image busybox --command -- sleep 10000
(if busybox does not sleep you get a crashloop backoff because it does not know how to be idle and kills itself)


### run a shell from a pod
k exec --stdin --tty nettools -- /bin/bash
k exec --stdin --tty busybox -- /bin/bash
