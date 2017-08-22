#pdf("width.pdf", height=6, width=6)
png("resolution7.png", height=6, width=6, units="in", res=300)


z = seq(-2,2,0.01)
W = sqrt(1+z^2)



plot(c(-2,2), c(0,2.2), type="n", xlab=expression("z ["*z[0]*"]"), ylab=expression("W ["*W[0]*"]"))

rect(-1, -1, 1, 3, col='gray', border="transparent")
abline(h=c(0,1,1.4142), lty="dotted", lwd=0.5)
box()

lines(z,W)

arrows(c(-1,1.5,2), c(2.1,0,0), c(1,1.5,2), c(2.1,1,1.4142), code=3, length=0.1, angle=10)

text(1.5,0.5,labels=expression(W[0]),pos=2,srt=90)

text(2,0.71, labels=expression(sqrt(2) %.% W[0]), pos=2,srt=90)

text(0,2.1,labels=expression(2 %.% z[0]), pos=3)

dev.off()
