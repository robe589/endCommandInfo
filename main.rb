#coding: utf-8
require 'bundler'
Bundler.require

require 'open3'

require './account.rb'
require './GmailSend.rb'


def main()
	senderAddress=$senderAddress
	sendAddress=$sendAddress
	command=ARGV[0]

	if command == nil
		puts '実行するコマンドをコマンドライン引数に入力してください'
		return -1
	end
	gmail=GmailSend.new(senderAddress,$password)

	i=0
	output=Array.new
	IO.popen(command) do |io|
		while line = io.gets
			puts line
			output[i]=line
			i+=1
		end
	end
	result=$?.to_s
	puts 'result='+result

	subject='コマンド実行結果'
	body='実行結果は'+result+"\n\n実行出力は\n"
	output.each do  |str|
		body+=str
	end
	gmail.sendMail(sendAddress,subject,body)
end

main()
