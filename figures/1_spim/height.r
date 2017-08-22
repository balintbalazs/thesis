#pdf("height.pdf", width=6, height=6)
png("height.png", height=6, width=6, units="in", res=300)

angol = FALSE;

x = seq(-2,2,0.01)
I = exp(-x^2)

px = seq(-0.47,0.47,0.01)
pI = exp(-px^2)
px = c(px,rev(px))
pI = c(pI, rep(-1,length(pI)))

if (angol) {plot(x,I,'l', xlab=expression("x ["*W[x*","*0]*"]"), ylab="normalized intensity")
}else{plot(x,I,'l', xlab=expression("x ["*W[x*","*0]*"]"), ylab="normalizált intenzitás")}
polygon(px, pI, col="gray")
box()

lines(c(-3,0.47), c(0.8, 0.8), lty="dotted")

dev.off()
