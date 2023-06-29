for url in $(cat $1)
do
	gau --subs --from 200101 --to 202304 --providers wayback,commoncrawl,otx,urlscan --threads 200 $url | grep https | grep $url | grep -Eo 'https?://[^/]+/([^/]+/){1}' | grep -vE '=' | sort -u | uniq  > LFISpider.txt
	nuclei -l LFISpider.txt -t Linux-LFI.yaml -bs 50 -rl 1000 -nc -o Linux-LFI-$url.txt
	nuclei -l LFISpider.txt -t windows-LFI.yaml -bs 50 -rl 1000 -nc -o Windows-LFI-$url.txt
done
