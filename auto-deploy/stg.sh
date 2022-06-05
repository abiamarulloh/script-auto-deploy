# Install Dependencies
npm i

# Build Project
npm run build:ssr

# Deploy
ls -la
ls -la dist
ssh -i auto-deploy/server-key/id_rsa root@103.179.56.211 rm -rf /var/lib/jenkins/workspace/sewalahan-landing/dist
scp -i auto-deploy/server-key/id_rsa -r dist root@103.179.56.211:/var/lib/jenkins/workspace/sewalahan-landing
ssh -i auto-deploy/server-key/id_rsa root@103.179.56.211 pm2 restart testing-auto-deploy

rm -rf dist

# Save Log History after Deploy
chmod -R 777 auto-deploy/logs/stg.txt
echo "Commit: $(git log -n 1 --pretty=format:"%H")" | tee -a auto-deploy/logs/stg.txt
echo "$(date)" | tee -a  auto-deploy/logs/stg.txt
echo "================================================" | tee -a  auto-deploy/logs/stg.txt
chmod 0555 auto-deploy/logs/stg.txt
