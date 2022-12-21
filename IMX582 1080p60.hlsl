sampler s0 : register(s0);
float4 p0 : register(c0);
float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float dx = 1.0 / p0[0];
	float dy = 1.0 / p0[1];
	float4 c = tex2D(s0, tex);
	float4 lt = tex2D(s0, tex + float2(-dx, -dy));
	float4 rt = tex2D(s0, tex + float2(dx, -dy));
	float4 lb = tex2D(s0, tex + float2(-dx, dy));
	float4 rb = tex2D(s0, tex + float2(dx, dy));
	float4 m;
	float4 dlt;
	float4 drt;
	float4 dlb;
	float4 drb;
	float4 t;
	m = (lt + rb) * 0.5;
	dlt = step(0.125, abs(lt - m));
	drt = step(0.125, abs(rt - m));
	dlb = step(0.125, abs(lb - m));
	drb = step(0.125, abs(rb - m));
	t.r = 0.5 * max((1.0 - dlt.r) * drt.r * (1.0 - dlb.r) * (1.0 - drb.r), (1.0 - dlt.r) * (1.0 - drt.r) * dlb.r * (1.0 - drb.r));
	t.g = 0.5 * max((1.0 - dlt.g) * drt.g * (1.0 - dlb.g) * (1.0 - drb.g), (1.0 - dlt.g) * (1.0 - drt.g) * dlb.g * (1.0 - drb.g));
	t.b = 0.5 * max((1.0 - dlt.b) * drt.b * (1.0 - dlb.b) * (1.0 - drb.b), (1.0 - dlt.b) * (1.0 - drt.b) * dlb.b * (1.0 - drb.b));
	t.a = 0.0;
	c = lerp(c, m, t);
	m = (rt + lb) * 0.5;
	dlt = step(0.125, abs(lt - m));
	drt = step(0.125, abs(rt - m));
	dlb = step(0.125, abs(lb - m));
	drb = step(0.125, abs(rb - m));
	t.r = 0.5 * max(dlt.r * (1.0 - drt.r) * (1.0 - dlb.r) * (1.0 - drb.r), (1.0 - dlt.r) * (1.0 - drt.r) * (1.0 - dlb.r) * drb.r);
	t.g = 0.5 * max(dlt.g * (1.0 - drt.g) * (1.0 - dlb.g) * (1.0 - drb.g), (1.0 - dlt.g) * (1.0 - drt.g) * (1.0 - dlb.g) * drb.g);
	t.b = 0.5 * max(dlt.b * (1.0 - drt.b) * (1.0 - dlb.b) * (1.0 - drb.b), (1.0 - dlt.b) * (1.0 - drt.b) * (1.0 - dlb.b) * drb.b);
	t.a = 0.0;
	return lerp(c, m, t);
}
