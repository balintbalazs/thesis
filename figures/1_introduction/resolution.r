angol = TRUE;

n = 1.333
lambda = 0.510
alpha = seq(0, pi/2, 0.01)
na = n*sin(alpha)
lateral = lambda / sqrt(3-2*cos(alpha)-cos(2*alpha))
axial = lambda / (1-cos(alpha))
ratio = axial/lateral

#pdf(file="resolution7.pdf", width=7, height=7)
png("resolution7.png", height=7, width=7, units="in", res=300)

par(oma=c(0,0,0,2))

plot(na, lateral, type="l", log="y",  col="white", xlim=c(0,1.3), ylim=c(0.1,40), ann=F, yaxt="n");
abline(h=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20,30,40), col="gray")
lines(na, lateral, col="red")
lines(na, axial, col="blue")
axis(2, at=c(0.1,1,10))

par(new=T)
plot(na, ratio, type="l", col="green", xlim=c(0,1.3), ylim=c(0,30), ann=F, axes=F)
axis(4, pretty(0:30), col="green")
legend("topright", legend=c("axial", "lateral", "axial/lateral"), col=c("blue", "red", "green"), lty=1, bg="white")
if (angol) {
title(xlab="NA", ylab=expression("Resolution ("*mu*"m)"))
mtext("axial/lateral ratio", side="4", line=3)
} else {
title(xlab="NA", ylab=expression("Felbontás ("*mu*"m)"))
mtext("axiális/laterális arány", side="4", line=3)
}
dev.off()
